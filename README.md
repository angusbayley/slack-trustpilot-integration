# GoCardless Slack TrustPilot

Posts new Trustpilot reviews to GoCardless's #general room in Slack for all to see.

## Running Locally

Prerequisites:
- a (Mailgun)[https://mailgun.com] account (free tier is fine)
- (ngrok)[https://ngrok.com/download]

    git clone REPO_URL
    cd REPO
    bundle install
    ngrok 4567
    SLACK_PATH=x SLACK_CHANNEL=y bundle exec ruby app.rb

...where:
x = everything after `https://hooks.slack.com` in your Slack webhook URL
y = the name of the channel you want to post to in Slack

Redirect your Trustpilot review emails to Mailgun (we use a Gmail filter), and set up a route in Mailgun to forward it to your ngrok instance's URL + `/trustpilot-webhook`.

New Trustpilot emails (or old ones that you forward) will now appear in your Slack room!