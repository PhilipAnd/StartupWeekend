# -*- coding: utf-8 -*-
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bundler'
require 'json'
require 'cgi'
require 'sinatra/base'
require 'mongoid'
require 'models/publisher'
require 'models/advertiser'
require 'models/advertisement'
require 'models/placement'

 
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


  get '/advertisers' do
    json Advertiser.all.asc(:klout_score)
  end

  get '/reject' do
    advertiser = Advertiser.find(params[:advertiser_id])
    publisher = Publisher.find(params[:publisher_id])

    publisher.placements.each do |place|
      place.advertiser_rejects = Array.new unless place.advertiser_rejects
      unless place.advertiser_rejects.include?(advertiser.id)
        place.advertiser_rejects << advertiser.id 
        place.save
      end
    end if advertiser && publisher

    json ""
  end

  get '/approve' do
    advertiser = Advertiser.find(params[:advertiser_id])
    publisher = Publisher.find(params[:publisher_id])

    publisher.placements.each do |place|
      place.advertiser_approves = Array.new unless place.advertiser_approves
      unless place.advertiser_approves.include?(advertiser.id)
        place.advertiser_approves << advertiser.id
        place.save
      end
    end if advertiser && publisher

    json ""
  end

  get '/ads' do
    json Advertisement.all.limit(20)
  end

  get '/rejected_ads' do
    pub = Publisher.find(params[:publisher_id])
    rejected = Array.new
    pub.placements.each do |place|
      rejected += place.advertiser_rejects if place.advertiser_rejects
    end

    rejected.flatten.map{ |ad_id| Advertisement.find(ad_id)}
  end

  # TODO: I don't think we need to expose this to the frontend - We might just use it in a background job
  get '/user-info' do
    json settings.user_info.get_info(params[:q])
  end

end

