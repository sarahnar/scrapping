#! /usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

def firstLink(links, visitedUrls)
    selected = 0
    href = ''
    loop do
        break if ! links[selected]
        res = links[selected].to_html.match(/href="(\/wiki\/[^\/:"]+)"/)
        if res && ! visitedUrls["https://fr.wikipedia.org" + res[1]] then
            href = res[1]
            break
        end
        selected += 1
    end
    return href
end

def getWikiPage(url, visitedUrls)
    page = open("https://fr.wikipedia.org" + url)
    doc = Nokogiri::HTML(page)
    links = doc.css("#mw-content-text p > a")
    visitedUrls.store(page.base_uri.to_s, true)
    href = firstLink(links, visitedUrls)
    page = Hash["url" => page.base_uri.to_s, "link" => href]
    puts page
    getWikiPage page["link"], visitedUrls if href != "/wiki/Philosophie" && href != ""
end

def randomPage()
    getWikiPage("/wiki/Sp%C3%A9cial:Page_au_hasard", Hash.new)
end

randomPage()