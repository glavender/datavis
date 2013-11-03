require 'nokogiri'
require 'open-uri'

page1 = Nokogiri::HTML(open("http://www.dpreview.com/"))
articles1 = page1.css('.articles .article .headline .title a')

page2 = Nokogiri::HTML(open("http://www.canonwatch.com/"))
articles2 = page2.css('.posttitle a')
  
page3 = Nokogiri::HTML(open("http://www.canonrumors.com/"))
article3 = page3.css('.post h2 a')

puts "Please enter a search term (e.g., Canon):"
term = gets.chomp.downcase
File.open('articles.html', 'w') do |f|
  
  f.puts("<link rel=\"stylesheet\" href=\"styles.css\">")
  f.puts("<html>")
  f.puts("<head>")
  f.puts("  <title>Digital photography articles</title>")
  f.puts("</head>")
  f.puts("<body>")
  f.puts("  <h1>Digital photography articles on \"#{term}\"</h1>")
  f.puts("  <div class=\"dpreview\">")
  f.puts("  <h2>Articles from DPReview</h2>")
  f.puts("  <ul>")

  articles1.each do |article|
    f.puts("    <li><a href=\"" + article['href'] + "\">" + article.text + "</a></li>") if article.text.downcase.include? term
  end

  f.puts("  </ul>")
  f.puts("  </div>")
  f.puts("  <div class=\"canonwatch\">")
  f.puts("  <h2>Articles from CanonWatch</h2>")
  f.puts("  <ul>")
  articles2.each do |article|
    f.puts("    <li><a href=\"" + article['href'] + "\">" + article.text + "</a></li>") if article.text.downcase.include? term
  end
f.puts("  </ul>")
f.puts("  </div>")
f.puts("  <div class=\"canonrumors\">")
f.puts("  <h2>Articles from CanonRumors</h2>")
  f.puts("  <ul>")
  article3.each do |article|
    f.puts("    <li><a href=\"#{article['href']}\">#{article.text}</a></li>") if article.text.downcase.include? term
  end
  f.puts("  </ul>")
  f.puts("  </div>")
  f.puts("</body>\n")
  f.puts("</html>\n")
end
