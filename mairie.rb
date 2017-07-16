#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage(name, href)
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com" + href[1..-1]))
    res = Hash[
        "name" => name,
        "email" => doc.xpath("//tr//td//p[@class = 'Style22']//font")[11].to_s[16..-8] 
    ]
    
    puts res
    return res
end


def get_all_the_urls_of_val_doise_townhalls()
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

    result = Array.new
    doc.xpath("//table[@class = 'Style20']//a").each do |link| 
        #puts link.to_html
        res = link.to_html.match(/href="(.+)">(.+)<\/a>/)
        if res then
            result.push get_the_email_of_a_townhal_from_its_webpage(res[2], res[1]) 
        end
    end
    return result
end

get_all_the_urls_of_val_doise_townhalls()