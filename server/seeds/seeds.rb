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
	(1...advitisers.size).each do |i|
		temp_adv = advitisers[i]
		advitiser = Advertiser.new
		advitiser.username = temp_adv[:username]
		advitiser.klout_score = temp_adv[:klout_score]
		advitiser.website = temp_adv[:website]
		advitiser.description = temp_adv[:description]
		advitiser.save

		1.upto 15 do
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
		{:username => "Securifi", :description =>"Easy Touchscreen WiFi Router. Easier Home Automation. Exquisitely Designed.", :website => "www.cola.com", :klout_score=> 20},
		{:username => "Outdoor Tech", :description =>"Wireless Audio", :website => "www.carlsberg.com", :klout_score=> 21},
		{:username => "Fusion Charts", :description =>"21,000 customers. 450,000 users. A billion charts per month. Download Now.", :website => "www.test.com", :klout_score=> 10},
		{:username => "Dropifi", :description =>"Supercharge your website with the simplest lead generation/customer support tool", :website => "www.test.com", :klout_score=> 10},
		{:username => "Cloud9", :description =>"Not your Dad's IDE. FREE Membership Available", :website => "www.test.com", :klout_score=> 10},
		{:username => "BigCommerce", :description =>"Create a successful online store", :website => "www.test.com", :klout_score=> 10},
		{:username => "Bug Herd", :description =>"Beautifully simple bug tracking for your websites and web applications.", :website => "www.test.com", :klout_score=> 10},
		{:username => "Braintree payments", :description =>"AUTHENTIC: Open APIs, a strong developer community, and rave-worthy support.", :website => "www.test.com", :klout_score=> 10},
		{:username => "Campaign Monitor", :description =>"Send beautiful email newsletters with Campaign Monitor", :website => "www.test.com", :klout_score=> 10},
		{:username => "Helpscount", :description =>"Built for small business, you can get up & running with Help Scout in 4 minutes", :website => "www.test.com", :klout_score=> 10},
		{:username => "Groovemade", :description =>"Made of 100% recycled skateboards - Free shipping w/ code: vibranti", :website => "www.test.com", :klout_score=> 10},
		{:username => "Mandril", :description =>"Mandrill is a new transactional email service from MailChimp. Try it today.", :website => "www.test.com", :klout_score=> 10},
		{:username => "GetHarvest", :description =>"Painless time tracking for creative professionals.", :website => "www.test.com", :klout_score=> 10},
		{:username => "Powtoon", :description =>"Create free animated videos and awesome presentations", :website => "www.test.com", :klout_score=> 10},
		{:username => "InfographicDesignTeam.com", :description =>"Custom Infographics Design and Data Visualization Services", :website => "www.test.com", :klout_score=> 10},
		{:username => "New Relic", :description =>"Speed Up Your Code! Try New Relic Free and Get This Awesome Shirt!", :website => "www.test.com", :klout_score=> 10}
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

