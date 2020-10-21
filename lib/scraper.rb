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
    doc = Nokogiri::HTML(open('https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html'))
      student_info = {}
      doc.css('div.vitals-container').each do |roster|
        binding.pry
        student_info = {
          :twitter => roster.css(""),
          :linkedin => roster.css(""),
          :github => roster.css(""),
          :blog => roster.css(""),
          :profile_quotes => roster.css("")
        }
      end
      student_info
    end

end
