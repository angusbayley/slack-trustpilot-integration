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
    quote = quote.gsub(/\r/, "").                 # removing other line breaks
            gsub(/\t/, "").gsub("    ", "")       # removing tabs
    quote = quote[quote.index("<br>") + "<br>".length..-1]
    quote_title = "*#{quote["<br>\n\n".length..quote.index("</p>")-1]}*"
    quote_body = quote[quote.index("</p>") + "</p><p>\n".length..-1].
          sub("<p>","").
          sub("</p>","").
          strip
    quote_body = "\"#{quote_body}\"".split("\n").map { |paragraph| (paragraph=="" ? "#{paragraph}" : "_#{paragraph}_") }.join("\n").strip
    quote_title + "\n" + quote_body
  end

  def format_link(link)
    link.sub!('<a href="',"")
    link[0, link.index('"')]
  end

end