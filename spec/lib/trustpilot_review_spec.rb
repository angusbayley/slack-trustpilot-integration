require 'spec_helper'

def load_fixture(filepath)
  File.read(File.join("spec", "fixtures", filepath))
end

describe TrustpilotReview do
  let(:html) { load_fixture('review.html') }
  let(:review) { described_class.new(html) }

  describe "#overview" do
    subject(:overview) { review.overview }

    it "says it's a new review" do
      expect(overview).to include("You've got a new review")
    end

    it "includes a bolded name" do
      expect(overview).to include("*Peter*")
    end

    it "includes the number of stars" do
      expect(overview).to include("5 stars")
    end

    it "does not include the quote" do
      expect(overview).not_to include("Great for settling bills with friends")
    end
  end

  describe "#quote" do
    subject(:quote) { review.quote }

    it "extracts the right quote" do
      expect(quote).to include("Great for settling bills with friends")
      expect(quote).to include("I've used GoCardless several times to collect money for bills, IOUs, food runs etc with friends. Couldn't ask for a better product for the job.")
    end
  end

  describe "#link" do
    subject(:link) { review.link }
    let(:link_url) { "http://email.trustpilot.com/wf/click?upn=sGkosZlD9jiMt7Zq6feVr7CD2KZDcVjiSkNBn-2F03NJeTuOf2I31jIOjFqxpxBAtCpgYTfdNnfrRHsyG7YCxfemncGBuJGHU9S3Fm6qkm3KIv5RSgedhNi7laJn-2FvNDvI_-2BuyqbAT6LrWvGmCRH8NeQT8Zo-2F2yLGDQ6Yk6mTg8Vt3GwY4Py5sHBQ4s32-2BfjbQhqV8KJzPKXWqYKpsxwW7r-2FLLffZuAdwk4TgUjtRRbPSoh83kvN1oN-2FFiDZ95Lr-2F8cqw4RFaSaqEeM-2B8bCREOxyOeSvb1NvNfSrgp6WA1vBDonvexXg-2F7PvTUAMXNy2QYZ2JXcngJ4pj5tJQxZa36XdbN1gx1fQm-2F-2BasFQWQ1ZzcnPe-2FUG26X-2FkXGIAIAGhZER" }

    it "contains the right link_URL" do
      expect(link).to include(link_url)
    end

    it "wraps the url in a slack friendly tag" do
      expect(link).to start_with("<")
      expect(link).to end_with("|see the review here>")
    end
  end
end
