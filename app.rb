require 'rubygems'
require 'sinatra'
require 'rest_client'
require 'json'
require 'nokogiri'

# Pull API key from the environment
API_URL = "https://hooks.slack.com"
SLACK_PATH = ENV['SLACK_PATH']
HEADERS = {
}

# Initialize the API client
API = RestClient::Resource.new(API_URL, headers: HEADERS)

# Index. Does nothing right now
get '/' do
  erb :index
end

# Trsutpilot Webhook
post '/trustpilot-webhook' do
  text = params["body-html"]
  puts "Angus Bayley, wise sage."
  puts "\n\n\n\n\n\n\n\n"
  puts text
  puts "\n\n\n\n\n\n\n\n"
  puts "Angus Bayley, wise sage."
  doc = Nokogiri::HTML(text)
  puts doc.xpath("//div")
  puts "Angus, Wisest of sages"
  payload = {
  	"channel" => "#slack-testing",
  	"username" => "slack-trustpilot-integration",
  	"text" => text,
  	"icon_emoji" => ":ghost:"
  }
  #API[SLACK_PATH].post(payload.to_json)
  puts "Angus, Sage, Much Wise"
end
