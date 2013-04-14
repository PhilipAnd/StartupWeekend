$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bundler'
require 'json'
require 'sinatra/base'
require 'cgi'
require 'mongoid'
require './services'
require './models/publisher'
require './models/placement'
require './models/advertiser'
require './models/advertisement'


 
Mongoid.load!("mongoid.yml")

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
	ser = UserInfoService.new(Twitter.new, Klout.new)

	(1...advitisers.size).each do |i|
		temp_adv = advitisers[i]

		user_info = ser.get_info(temp_adv[:username])

		advitiser = Advertiser.new
		advitiser.username = temp_adv[:username]
		advitiser.klout_score = user_info[:klout_score]
		advitiser.website = temp_adv[:website]
		advitiser.description = temp_adv[:description]
		advitiser.img_url = user_info[:image]
		advitiser.save

		ad = ads[i]
		advitiser.advertisements.create(
			{:width => ad[:width], 
			 :height => ad[:height],
			 :creative => ad[:creative],
			 :description => temp_adv[:description],
			 :img_name => ad[:img_name]})
		
	end	
end


def advitisers
	[
		{:username => "Securifi", :description =>"Easy Touchscreen WiFi Router. Easier Home Automation. Exquisitely Designed.", :website => "www.cola.com", :klout_score=> 20, :img_url =>"https://si0.twimg.com/profile_images/3323291500/7f858de8d10ab062b0716288f10b063b_normal.jpeg"},
		{:username => "Outdoor Tech", :description =>"Wireless Audio", :website => "www.carlsberg.com", :klout_score=> 21, :img_url =>"https://si0.twimg.com/profile_images/3495941480/64fb59e188b55c4b6b05680afe7ae655_normal.jpeg"},
		{:username => "Fusion Charts", :description =>"21,000 customers. 450,000 users. A billion charts per month. Download Now.", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/2150202125/fc_fb_normal.png"},
		{:username => "Dropifi", :description =>"Supercharge your website with the simplest lead generation/customer support tool", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/2304731705/4puqjdx291pyfxrxhfq4_normal.png"},
		{:username => "Cloud9", :description =>"Not your Dad's IDE. FREE Membership Available", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/2248470114/Cloud9-IDE-Avatar-new_normal.png"},
		{:username => "BigCommerce", :description =>"Create a successful online store", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/3439298616/c2e762ff34cdcbc2d75daa4a0e38b7a1_normal.jpeg"},
		{:username => "Bug Herd", :description =>"Beautifully simple bug tracking for your websites and web applications.", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/1182953199/logo2_normal.png"},
		{:username => "Braintree payments", :description =>"AUTHENTIC: Open APIs, a strong developer community, and rave-worthy support.", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/1891596045/new-dots_normal.png"},
		{:username => "Campaign Monitor", :description =>"Send beautiful email newsletters with Campaign Monitor", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/2327138659/y11562ftv2xht7t3z6ce_normal.png"},
		{:username => "Groovemade", :description =>"Made of 100% recycled skateboards - Free shipping w/ code: vibranti", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/2320280400/3ne4yjc67kpyh92gqmko_normal.jpeg"},
		{:username => "Mandril", :description =>"Mandrill is a new transactional email service from MailChimp. Try it today.", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/520974102/header2_normal.jpg"},
		{:username => "GetHarvest", :description =>"Painless time tracking for creative professionals.", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png"},
		{:username => "Powtoon", :description =>"Create free animated videos and awesome presentations", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/3278304400/fc3e54dc706d64219fb4e2696b0ae9ea_normal.png"},
		#{:username => "InfographicDesignTeam.com", :description =>"Custom Infographics Design and Data Visualization Services", :website => "www.test.com", :klout_score=> 10, :img_url =>""},
		{:username => "New Relic", :description =>"Speed Up Your Code! Try New Relic Free and Get This Awesome Shirt!", :website => "www.test.com", :klout_score=> 10, :img_url =>"https://si0.twimg.com/profile_images/3406837805/0779891adbade5fba538642cbd6d3953_normal.png"},
		{:username => "Helpscount", :description =>"Built for small business, you can get up & running with Help Scout in 4 minutes", :website => "www.test.com", :klout_score=> 10, :img_url =>""}
	]
end

def ads
	[
		{:width => 500, :height => 300, :creative => "html", :img_name => "securifi_250.jpg"},
		{:width => 350, :height => 180, :creative => "html", :img_name => "outdoortech_250.jpg"},
		{:width => 130, :height => 100, :creative => "html", :img_name => "fusioncharts_250.jpg"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "dropifi_250.jpg"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "cloud9_250.jpg"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "bigcommerce_250.jpeg"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "bugherd_250.png"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "braintree_250.jpg"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "campaignMonitor_250.png"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "groovemade_250.jpg"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "mandril_250.png"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "getharvest_250.png"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "powtoon_250.jpg"},
		#{:width => 100, :height => 80, :creative => "html", :img_name => "glyphicons-halflings.png"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "newrelic_250.jpeg"},
		{:width => 100, :height => 80, :creative => "html", :img_name => "helpscout_250.png"}
	]
end


def ad_sizes
	[
		{:width => 500, :height => 300},
		{:width => 350, :height => 180},
		{:width => 100, :height => 80}
	]
end

puts "start seeding..."
mockup

