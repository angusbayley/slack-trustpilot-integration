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

    it "includes the number of stars"
  end

  describe "#quote" do
    subject(:quote) { review.quote }

    it "extracts the right quote"
  end

  describe "#link" do
    subject(:link) { review.link }

    it "contains the right URL"
    it "wraps the url in a slack friendly tag"
  end
end
