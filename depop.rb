#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'uri'

search_term = URI.escape ARGV[0]
pages = ARGV[1].to_i

#depop search
search_url = "https://www.depop.com/search/?q="
driver = Selenium::WebDriver.for(:firefox)
driver.get(search_url + search_term)
(pages - 1).times do 
  driver.execute_script("window.scrollTo(0, document.body.scrollHeight)")
  sleep 3
end
response = driver.page_source
md = response.scan /href="(\/products.*?)".*?(\$\d*|\$.*?\.\d*)/
md.each do |item_info|
  puts "https://www.depop.com" + item_info[0]
  puts item_info[1]
end
driver.quit
