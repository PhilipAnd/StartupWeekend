require File.join(File.dirname(__FILE__), 'app.rb')
require 'rack/test'
require 'test/unit'
require 'json'

class JsonContent
  def initialize(body)
    @json = nil
    begin
      @root = JSON.parse(body)
      @valid = true
    rescue
      @valid = false
    end
  end

  def valid?
    @valid
  end

  def root_element
    @root
  end

  def first
    root_element.first
  end

  def last
    root_element.last
  end

  def [](path)
    select(path)
  end

  def select(path)
    root = @root
    path = path.to_s.split("/")
    while path.any?
      if root.is_a? Array
        root = root[path.shift.to_i]
      elsif ! root.nil?
        root = root[path.shift]
      end
    end
    root
  end

  def dump
    pp @root
  end
end

class ApiTest < Test::Unit::TestCase
  include Rack::Test::Methods
  CONFIG = Rack::Builder.parse_file('config.ru').first
  def app
    CONFIG
  end

  def json_content
    JsonContent.new(last_response.body)
  end

  def with(param, &block)
    block.call(param)
  end

  def last_content_type
    last_response.content_type.split(";").first
  end

  def symbolize_keys(hash)
    hash.inject({}){|memo,(k,v)|
      memo[k.to_sym] = case
                       when v.is_a?(Array)
                         v.map {|value| value.is_a?(Hash) ? symbolize_keys(value) : value }
                       when v.is_a?(Hash)
                         symbolize_keys(v)
                       else
                         v
                       end
      memo
    }
  end
end
