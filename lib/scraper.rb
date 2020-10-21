require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
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
    html = Nokogiri::HTML(open(profile_url))
    students_info = {}
    html.css("div.social-icon-controler a").each do |student|
      url = student.attribute("href").value
      students_info[:twitter_url] = url if url.include?("twitter")
      students_info[:linkedin_url] = url if url.include?("linkedin")
      students_info[:github_url] = url if url.include?("github")
      students_info[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
    end
      students_info[:profile_quote] = html.css("div.profile-quote").text
      students_info[:bio] = html.css("div.bio-content p").text
     students_info

    end

end
