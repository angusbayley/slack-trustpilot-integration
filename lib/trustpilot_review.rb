# Generates a trust pilot review from HTML
class TrustpilotReview
  def initialize(html)
    @html = Nokogiri::HTML(html)
  end

  def overview
    ""
  end

  def quote
    ""
  end

  def link
    "<#{link_url}|see the review here>"
  end

  private

  def ptags
    doc.xpath("//div//p")
  end

  def atags
    doc.xpath("//a")
  end

  def link_url
  end
end

# ANGUS: You'll want to start here
# I'd move the below into helper methods and use them to complete the main methods defined
# above.
#
# def parse(html)
#   doc = Nokogiri::HTML(html)
#   p_tags = doc.xpath("//div//p").to_a
#   a_tags = doc.xpath("//a").to_a
#
#   overview = p_tags[0].to_s
#   review_body = p_tags[1].to_s
#   link = a_tags[0].to_s
#
#   review = {
#     overview => format_overview(overview),
#     review_body => format_review_body(review_body),
#     link => format_link(link)
#   }
# end
# def format_message(message)
#   message = message.sub("<p>","").
#         sub("</p>","").
#         sub("<strong>","*").
#         sub("</strong>","*").
#         strip
#   message[0, message.index('<br>')]
# end
#
# def format_review(review)
#   review = review.sub("<p>","").
#         sub("</p>","").
#         strip
#   review.insert(0, '_"')
#   review.insert(review.length, '"_')
# end
#
# def format_link(link)
#   link.sub!('<a href="',"")
#   link = link[0, link.index('"')]
#   "<#{link}|see the review here>"
# end
