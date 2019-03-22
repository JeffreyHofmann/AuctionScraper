#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'uri'

search_term = URI.escape ARGV[0]
pages = ARGV[1].to_i

#storenvy search
pages.times do |page_num|
  search_url = "https://www.storenvy.com/shop/"
  page = page_num != 0 ? "page-#{page_num+1}/" : ""
  tail = "?q="
  driver = Selenium::WebDriver.for(:firefox)
  driver.get(search_url + page + tail + search_term)
  sleep 3
  response = driver.page_source
  driver.close
  md = response.scan /href="(\/products.*?)"/
  links = []
  md.each do |item_info|
    links << item_info[0]
  end
  links.uniq!
  md = response.scan /^\s+<span class="price">(\$.*?\.\d*)<\/span>/
  prices = []
  md.each do |item_info|
    prices << item_info[0]
  end

  if (links.length != prices.length)
    #error
    exit
  end
  links.each.with_index do |link, i|
    puts "https://www.storenvy.com" + link
    puts prices[i]
  end
end