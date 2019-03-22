#!/usr/bin/env ruby

require 'rest-client'
require 'uri'

search_term = URI.escape ARGV[0]
pages = ARGV[1].to_i

#ebay search
pages.times do |page_num|
  search_url = "https://www.ebay.com/sch/i.html?&_nkw="
  page = "&_pgn=#{page_num+1}"
  response = RestClient.get search_url + search_term + page
  md = response.scan /results-listing\d+.*?href="(https:\/\/www.ebay.com\/itm.*?)".*?(\$\d*.\.\d*)/
  md.each do |item_info|
    puts item_info[0]
    puts item_info[1]
  end
end
