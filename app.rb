require 'rubygems'
require 'sinatra'
require 'rest_client'
require 'json'

# Pull API key from the environment
API_URL = "..."
API_KEY = ENV['API_KEY_ID']
HEADERS = {
}

# Initialize the API client
API = RestClient::Resource.new(API_URL, headers: HEADERS)

# Index. Does nothing right now
get '/' do
  erb :index
end

# Trsutpilot Webhook
get '/trustpilot-webhook' do
  puts params
end
