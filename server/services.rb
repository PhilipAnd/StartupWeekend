require 'scrape_tools'
require 'active_support/memoizable'

class Twitter

  extend ActiveSupport::Memoizable

  def initialize
    @session = WebSession.new("https://twitter.com/")
    @session.headers['user-agent'] = 'Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120405 Firefox/14.0a1'
    @session.headers['accept-language'] = "en,en-us;q=0.5"
  end

  #curl 'https://twitter.com/search/users?q=coca%20cola'|grep 'js-action-profile-name'|grep 'username'
  def search_users(query)
    request = Net::HTTP::Get.new("/search/users?q=#{CGI.escape(query)}")
    response = @session.request(request)
    raw = response.body.to_s
    results = []
    TagButcher.new(raw, :span).find_by_class('js-action-profile-name').each do |tag|
      if tag[:class_names].include? 'username'
        results << CGI.unescapeHTML(tag[:inner_html]).strip.gsub(/^@/, "")
      end
    end
    return results
  end
  memoize :search_users

end

class Klout

  extend ActiveSupport::Memoizable

  def initialize
    @key = 'gxhxukcwrb7x9umwdce5sx47'
  end

  # curl 'http://api.klout.com/v2/identity.json/twitter?screenName=CocaC%20ola&key=$KEY'
  def identity(twitter_name)
    uri = URI.parse("http://api.klout.com/v2/identity.json/twitter?screenName=#{CGI.escape(twitter_name)}&key=#{CGI.escape(@key)}")
    response = Net::HTTP.get_response(uri)
    data = JSON.parse(response.body.to_s)
    data ? data['id'] : nil
  end
  memoize :identity

  def score(twitter_name)
    id = identity(twitter_name)
    'http://api.klout.com/v2/user.json/45598950992084523/score'
    uri = URI.parse("http://api.klout.com/v2/user.json/#{id}?key=#{CGI.escape(@key)}")
    response = Net::HTTP.get_response(uri)
    data = JSON.parse(response.body.to_s)
    data ? data['score']['score'] : nil
  end
  memoize :score

end
