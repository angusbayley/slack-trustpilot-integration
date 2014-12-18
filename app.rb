require 'rubygems'
require 'sinatra'
require 'rest_client'
require 'json'
require 'nokogiri'

# Pull API key from the environment
API_URL = "https://hooks.slack.com"
SLACK_PATH = ENV['SLACK_PATH']
SLACK_CHANNEL = ENV['SLACK_CHANNEL'] || "slack-testing"
HEADERS = {
}

# Initialize the API client
API = RestClient::Resource.new(API_URL, headers: HEADERS)

# Index. Does nothing right now
get '/' do
  erb :index
end

# Trustpilot Webhook
post '/trustpilot-webhook' do
  html = params["body-html"]
  doc = Nokogiri::HTML(html)
  p_tags = doc.xpath("//div//p").to_a
  a_tags = doc.xpath("//a").to_a
  # puts a_tags
  
  message = p_tags[0].to_s
  review = p_tags[1].to_s
  link = a_tags[0].to_s
  
  message = format_message(message)
  review = format_review(review)
  link = format_link(link)
  
  payload = {
  	"channel" => "##{SLACK_CHANNEL}",
  	"username" => "Trustpilot",
  	"text" => message + "\n" + "\n" + review + "\n" + "\n" + link,
  	"icon_emoji" => ":trustpilot:"
  }

  API[SLACK_PATH].post(payload.to_json)
end



def format_message(message)
  message = message.sub("<p>","").
        sub("</p>","").
        sub("<strong>","*").
        sub("</strong>","*").
        strip
  message[0, message.index('<br>')]
end

def format_review(review)
  review = review.sub("<p>","").
        sub("</p>","").
        strip
  review.insert(0, '_"')
  review.insert(review.length, '"_')
end

def format_link(link)
  link.sub!('<a href="',"")
  link = link[0, link.index('"')]
  "<#{link}|see the review here>"
end