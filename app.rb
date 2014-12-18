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
  doc = Nokogiri::HTML(text)
  new_doc = doc.xpath("//div//p").to_a
  review = new_doc[1].to_s
  review.sub!("<p>","").sub!("</p>","").strip!
  puts review
  payload = {
  	"channel" => "#slack-testing",
  	"username" => "slack-trustpilot-integration",
  	"text" => review,
  	"icon_emoji" => ":ghost:"
  }
  API[SLACK_PATH].post(payload.to_json)
end
