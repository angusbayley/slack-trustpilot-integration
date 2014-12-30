require 'rest_client'

class SlackNotifier
  API_URL = "https://hooks.slack.com"

  def initialize(path: nil, channel: nil)
    @path = path
    @channel = channel
  end

  # You should be able to integration test this using something like webmock...
  def notify_of_review(review)
    payload = payload_for_review(review).to_json
    api[@path].post(payload)
  end

  private

  # ||= will only set @api the first time, so it'll 'cache' the client
  def api
    @api ||= RestClient::Resource.new(API_URL)
  end

  # Ideally we'd spec this, but it won'e be called outside this class so it's a private
  # method. Instead, we check the 'result' or 'effect' this has.
  # For example, we could generate a sample JSON payload, and check that the slack URL is
  # posted to with it. Look up Webmock....
  def payload_for_review(review)
    text = "#{review.overview}"
    {
      channel: "##{@channel}",
      username: "Trustpilot",
      text: "#{review.overview}\n\n#{review.body}\n\n#{review.link}",
      icon_emoji: ":trustpilot:"
    }
  end
end
