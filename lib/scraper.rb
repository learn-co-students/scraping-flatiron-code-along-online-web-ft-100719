require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def print_courses         #makes the courses, and then prints them out in the specific format
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
  def get_page                #uses Nokogiri to get the entire page HTML
    doc = Nokogiri::HTML(open('http://learn-co-curriculum.github.io/site-for-scraping/courses'))
      #binding.pry
  end
  
  def make_courses            #accesses the get_courses method, and iterates through all of the courses to create Course class objects
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end
  
  def get_courses             #searches through the page to get all the css with the class post
    self.get_page.css('.post')
  end
  
end



