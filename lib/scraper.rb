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
    doc = Nokogiri::HTML(open(profile_url))
      student_info = {}
      container = doc.css('div.vitals-container').each do |roster|
        links = roster.css("div.social-icon-container a").attribute("href").value
        if links.include?("twitter")
          student_info[:twitter]
        elsif links.include?("linkedin")
          student_info[:linkedin]
        elsif links.include?("github")
          student_info[:github]
        else
          student_info[:blog]
        end
          student_info[:profile_quotes] = roster.css("div.profile-quote").text,
        end
          student_info[:bio] = doc.css("div.bio-content.content-holder p").text
      student_info
    end

end
