# -*- coding: utf-8 -*-
require 'rubygems'
require 'net/http'
require 'net/https'
require 'open-uri'
require 'date'
require 'cgi'

# $debug = $stderr
$debug = nil

def verbose(str)
  $debug << str.to_s + "\n" if $debug
end

class CookieJar < Hash
  def read(response)
    response['set-cookie'].to_s.split(/,/).each do |line|
      match = line.strip.match(/^([^=]+)=([^;]+).*/)
      self[match[1]] = match[2] if match
    end
  end

  def apply!(request)
    request['cookie'] = self.map {|k,v| "#{k}=#{v}" }.join(";")
  end
end

class WebSession
  attr_accessor :headers

  def initialize(uri, cookies = nil)
    uri = URI.parse(uri) unless uri.kind_of? URI
    @cookies = cookies || CookieJar.new
    @headers = {}
    @http = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == "https"
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    @http.set_debug_output $stderr if $debug
    if block_given?
      @http.start
      yield self
      @http.finish if @http.started?
    end
  end

  def request(req)
    @cookies.apply! req
    @headers.each {|(k,v)| req[k.to_s] = v.to_s }
    verbose req.to_s + " - " + req.path
    response = @http.request(req)
    @cookies.read response
    if response.code.to_i == 301 || response.code.to_i == 302
      verbose "** Following redirect: #{response['location']}"
      return self.request(Net::HTTP::Get.new(response['location']))
    end
    verbose response
    return response
  end

end

# A crude excuse for a parser
class TagButcher
  def initialize(html, tag = :div)
    flat = []
    stack = [{:tag => nil, :offset => nil, :children => []}]
    html.scan(/(<#{tag}[^>]*>)|(<\/#{tag}>)/m) do |m|
      position = Regexp.last_match.offset(0)[0]
      if m[0]
        stack << {:tag => m[0], :class_names => parse_class_names(m[0]), :offset => position, :children => []}
        flat << stack.last
      else
        element = stack.pop
        element[:inner_html] = html[(element[:offset] + element[:tag].length)..(position - 1)]
        stack.last[:children] << element
      end
    end
    @root = stack.last
    @elements = flat
  end

  def parse_class_names(tag)
    m = tag.match(/class="([^"]*)"/) || tag.match(/class='([^"]*)'/)
    m ? m[1].split(" ") : []
  end

  def root
    @root
  end

  def find_by_class(class_name)
    @elements.select {|element| element[:class_names].include? class_name }
  end

  def first
    @elements.first
  end

  def each(&block)
    @elements.each(&block)
  end

  def map(&block)
    @elements.map(&block)
  end

end
