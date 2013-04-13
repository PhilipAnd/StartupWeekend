require 'scrape_tools'
require 'active_support/memoizable'

class Twitter

  extend ActiveSupport::Memoizable

  def initialize
    @session = WebSession.new("https://twitter.com/")
    @session.headers['user-agent'] = 'Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120405 Firefox/14.0a1'
    @session.headers['accept-language'] = "en,en-us;q=0.5"
  end

  # <img class="avatar js-action-profile-avatar " src="https://si0.twimg.com/profile_images/1884480827/profilePic_normal.jpg" alt="Coca-Cola" data-user-id="26787673"/>
  #curl 'https://twitter.com/search/users?q=coca%20cola'|grep 'js-action-profile-avatar'
  #curl 'https://twitter.com/search/users?q=coca%20cola'|grep 'js-action-profile-name'|grep 'username'
  def search_users(query)
    request = Net::HTTP::Get.new("/search/users?q=#{CGI.escape(query)}")
    response = @session.request(request)
    raw = response.body.to_s
    results = []
=begin
    TagButcher.new(raw, :span).find_by_class('js-action-profile-name').each do |tag|
      if tag[:class_names].include? 'username'
        results << CGI.unescapeHTML(tag[:inner_html]).strip.gsub(/^@/, "")
      end
    end
=end
    TagButcher.new(raw, :img).find_by_class('js-action-profile-avatar').each do |tag|
      image = tag[:tag].match(/src="([^"]*)"/)[1]
      user_id = tag[:tag].match(/data-user-id="([^"]*)"/)[1]
      results << { :twitter_id => user_id, :image => CGI.unescapeHTML(image) }
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

  def identity(twitter_id)
    uri = URI.parse("http://api.klout.com/v2/identity.json/tw/#{CGI.escape(twitter_id)}?key=#{CGI.escape(@key)}")
    response = Net::HTTP.get_response(uri)
    data = JSON.parse(response.body.to_s)
    data ? data['id'] : nil
  end
  memoize :identity

  def score(twitter_id)
    klout_id = identity(twitter_id)
    uri = URI.parse("http://api.klout.com/v2/user.json/#{klout_id}?key=#{CGI.escape(@key)}")
    response = Net::HTTP.get_response(uri)
    data = JSON.parse(response.body.to_s)
    data ? data['score']['score'] : nil
  end
  memoize :score

end

class UserInfoService

  def initialize(twitter, klout)
    @twitter, @klout = twitter, klout
  end

  def get_info(query)
    info = @twitter.search_users(query).first
    info[:klout_score] = @klout.score(info[:twitter_id])
    info
  end

end
