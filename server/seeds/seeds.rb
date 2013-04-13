$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bundler'
require 'json'
require 'sinatra/base'
require 'cgi'
require 'mongoid'
require '../models/publisher'
require '../models/placement'
require '../models/advertiser'
require '../models/advertisement'


 
Mongoid.load!("../mongoid.yml")

def mockup
	cleanup
	mock_publishers
	mock_ads
end

def cleanup 
	puts "cleanup..."
	Publisher.delete_all
	Advertisement.delete_all
	Advertiser.delete_all
end

def mock_publishers
	puts "seeding publishers"
	pub = Publisher.new
	pub.username = "Qrate"
	pub.save

	1.upto 10 do
		size = ad_sizes[Random.rand(ad_sizes.size)]
		pub.placements.create(
			{:width => size[:width], 
			 :height => size[:height]}
			)
	end
end

def mock_ads
	puts "seeding advitisers"
	1.upto 5 do
		advitiser = Advertiser.new
		advitiser.username = advitisers[Random.rand(advitisers.size)][:username]
		advitiser.save

		1.upto 10 do
			ad = ads[Random.rand(ads.size)]
			advitiser.advertisements.create(
				{:width => ad[:width], 
				 :height => ad[:height],
				 :creative => ad[:creative]})
		end
	end	
end

def advitisers
	[
		{:username => "Coca cola", :description =>"drink", :website => "www.cola.com", :klout_score=> 20},
		{:username => "Carlsberg", :description =>"drink", :website => "www.carlsberg.com", :klout_score=> 21},
		{:username => "test", :description =>"test", :website => "www.test.com", :klout_score=> 10},
		{:username => "test2", :description =>"test2", :website => "www.test.com", :klout_score=> 10},
		{:username => "test3", :description =>"test3", :website => "www.test.com", :klout_score=> 10},
		{:username => "test4", :description =>"test4", :website => "www.test.com", :klout_score=> 10},
		{:username => "test5", :description =>"test5", :website => "www.test.com", :klout_score=> 10},
		{:username => "test6", :description =>"test6", :website => "www.test.com", :klout_score=> 10},
		{:username => "test7", :description =>"test7", :website => "www.test.com", :klout_score=> 10},
		{:username => "test8", :description =>"test8", :website => "www.test.com", :klout_score=> 10}
	]
end

def ad_sizes
	[
		{:width => 500, :height => 300},
		{:width => 350, :height => 180},
		{:width => 100, :height => 80}
	]
end

def ads
	[
		{:width => 500, :height => 300, :creative => "html"},
		{:width => 350, :height => 180, :creative => "html"},
		{:width => 100, :height => 80, :creative => "html"}
	]
end

puts "start seeding..."
mockup

