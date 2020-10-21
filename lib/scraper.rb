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
    doc = Nokogiri::HTML(open('https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html'))
      student_info = {}
      container = doc.css('div.vitals-container').each do |roster|
            container
          :twitter => roster.css("div.social-icon-container a").attribute("href").value,
          :linkedin => roster.css(""),
          :github => roster.css(""),
          :blog => roster.css(""),
        end
          :profile_quotes => roster.css("div.profile-quote").text,
        end
          :bio => doc.css("div.bio-content.content-holder p").text
      end
      student_info
    end

end
