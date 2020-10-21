require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open('https://learn-co-curriculum.github.io/student-scraper-test-page/index.html'))
      students = []

      doc.css('div.student-card').each do |roster|
        students << {
          :name => roster.css('h4.student-name').text,
          :location => roster.css('p.student-location').text,
          :profile_url => roster.css("a").attribute("href").value
          }
      end
      students
  end

  def self.scrape_profile_page(profile_url)
    page = Nokogiri::HTML(open(profile_url))
    student = {}
    links = page.css(".social-icon-container").css("a").map {|link| link.attr("href").text}
    links.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      else
        student[:blog] = link
      end
    end
    student[:profile_quote] = page.css(".profile-quote").text
    student[:bio] = page.css(".bio-content p").text
    student
  end
end
