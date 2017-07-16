#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

def getStockPrice
    doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all"))

    result = Array.new
    doc.css("#currencies-all > tbody > tr").each do |currency| 
        res = currency.to_html.match(/<td class="no-wrap currency-name">\s*<img.*>\s*<a href=".*">(.*)\s*<\/a>\s*<\/td>\s*<td.*\s*<td.*\s*(.*)\s*<\/td>\s*<td.*\s*<a.*">(.+)<\/a>/)
        if res then
            result.push(Hash["company" => res[1], "price" => res[3]])
        end
    end
    return result
end

loop do 
    puts getStockPrice()
    sleep 3600
end