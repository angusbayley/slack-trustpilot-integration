require 'spec_helper'

describe SlackNotifier do
  let(:html) { load_fixture('review.html') }
  let(:review) { TrustpilotReview.new(html) }
  let(:slack_updater) { SlackNotifier.new(path: "", channel: "") }

  describe "#notify_of_review" do
    it "should post the review to slack" do
    	stub_request(:any, "https://hooks.slack.com/")
    	slack_updater.notify_of_review(review)
		expect(WebMock).to have_requested(:post, "https://hooks.slack.com/")
	end
  end
end
