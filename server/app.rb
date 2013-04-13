$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bundler'
require 'json'
require 'cgi'
require 'sinatra/base'

class App < Sinatra::Base

  configure do
    set :public_folder, File.realpath(File.join(__FILE__, '..', '..', 'public'))
    set :static, true
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

end

