require 'rubygems'
require 'sinatra'
require 'json'
require 'nokogiri'

require_relative 'lib/slack_notifier'
require_relative 'lib/trustpilot_review'

# Pull settings from the environment
SLACK_PATH = ENV['SLACK_PATH'] || ""
SLACK_CHANNEL = ENV['SLACK_CHANNEL'] || "slack-testing"
#
# Index. Does nothing right now
get '/' do
  erb :index
end

# Trustpilot Webhook
post '/trustpilot-webhook' do
  review = TrustpilotReview.new(params["body-html"])

  slack_updater = SlackNotifier.new(path: SLACK_PATH, channel: SLACK_CHANNEL)
  slack_updater.notify_of_review(review)

  # Raise so Mailgun will retry - lazy debugging
  raise
end
