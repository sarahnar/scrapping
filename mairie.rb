#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_the_email_of_a_townhal_from_its_webpage 
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/vaureal.html"))
    puts doc.xpath("//tr//td//p[@class = 'Style22']//font")[11]
end
get_the_email_of_a_townhal_from_its_webpage()


def get_all_the_urls_of_val_doise_townhalls()
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

    doc.xpath("//table[@class = 'Style20']//a").each do |link| 
        #puts link.to_html
        h = {}
        res = link.to_html.match(/href="(.+)">(.+)<\/a>/)
        if res then
            h.store("href", res[1])
            h.store("name", res[2])
            puts h 
        end
    end
end

