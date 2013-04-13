$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bundler'
require 'json'
require 'sinatra/base'
require 'cgi'
require 'mongoid'
require 'models/publisher'


 
Mongoid.load!("mongoid.yml")

def mockup
	pub = Publisher.new
	pub.username = "Qrate"
	pub.save
end

def advitisers
	[
		"Coca cola"
	]
end

def size
	[
		{:width => 500, :height => 300},
		{:width => 350, :height => 180},
		{:width => 100, :height => 80}
	]
end

puts "start seeding..."
mockup

