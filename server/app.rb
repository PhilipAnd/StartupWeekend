# -*- coding: utf-8 -*-
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bundler'
require 'json'
require 'cgi'
require 'sinatra/base'
require 'mongoid'
require 'models/publisher'

 
Mongoid.load!("mongoid.yml")


require 'services'

$debug = $stderr

class App < Sinatra::Base

  configure do
    set :public_folder, File.realpath(File.join(__FILE__, '..', '..', 'public'))
    set :static, true
    set :user_info, Proc.new { UserInfoService.new(Twitter.new, Klout.new) }
  end

  helpers do
    def json(data, status_code = 200)
      status status_code
      content_type :json
      body data.to_json
    end
  end

  get '/' do
    send_file settings.public_folder + '/index.html'
  end


  get '/test.json' do
    content_type :json
    all_publishers = Publisher.all
    all_publishers.to_json
  end
  
  # TODO: I don't think we need to expose this to the frontend - We might just use it in a background job
  get '/user-info' do
    json settings.user_info.get_info(params[:q])
  end

end

