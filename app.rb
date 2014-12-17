require 'rubygems'
require 'sinatra'
require 'rest_client'
require 'json'

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
  text = params["body-plain"]
  payload = {
  	"channel" => "#slack-testing",
  	"username" => "pilot",
  	"text" => text,
  	"icon_emoji" => ":ghost:"
  }
  API[SLACK_PATH].post(payload.to_json)
end
