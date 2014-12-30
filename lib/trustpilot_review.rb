# Generates a trust pilot review from HTML
class TrustpilotReview
  def initialize(html)
    @html = Nokogiri::HTML(html)
  end

  def overview
    raw_overview = ptags[0].to_s
    format_overview(raw_overview)
  end

  def quote
    raw_quote = ptags[0].to_s + ptags[1].to_s
    format_quote(raw_quote)
  end

  def link
    "<#{link_url}|see the review here>"
  end

  private

  def ptags
    @html.xpath("//p").to_a
  end

  def atags
    @html.xpath("//a").to_a
  end

  def link_url
    format_link(atags[0].to_s)
  end

  def format_overview(overview)
    overview = overview.sub("<p>","").
          sub("</p>","").
          sub("<strong>","*").
          sub("</strong>","*").
          strip
    overview[0, overview.index("<br>")]
  end

  def format_quote(quote)
    quote.gsub!(/\n\t/, " ")
    quote.gsub!(/>\s*</, "><")
    quote = quote[quote.index("<br>") + "<br>".length, quote.length]
    quote = quote.sub("<br>", "*").
          sub("</p>", ".*").
          sub("<p>","").
          sub("</p>","").
          strip
    quote.insert(0, '_"')
    quote.insert(quote.length, '"_')
  end

  def format_link(link)
    link.sub!('<a href="',"")
    link[0, link.index('"')]
  end

end

# ANGUS: You'll want to start here
# I'd move the below into helper methods and use them to complete the main methods defined
# above.
#
# def parse(html)
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
