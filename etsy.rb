#!/usr/bin/env ruby

require 'rest-client'
require 'uri'

search_term = URI.escape ARGV[0]
pages = ARGV[1].to_i

#etsy search
pages.times do |page_num|
  search_url = "https://www.etsy.com/search?q="
  page = "&ref=pagination&page=#{page_num+1}"
  response = RestClient.get search_url + search_term + page
  md = response.scan /.*?href="(https:\/\/www\.etsy\.com\/listing.*?)"/
  links = []
  md.each do |item_info|
    links << item_info[0]
  end
  #collect price info for item listings
  links.each do |link|
    puts link
    response = RestClient.get link
    md = response.scan /^\s*(?!<meta property="etsymarketplace:price" content=")(\$.*?\.\d*)/
    md.each do |price_info|
      puts price_info[0]
    end
  end
end
