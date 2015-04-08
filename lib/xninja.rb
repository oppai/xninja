require 'open-uri'
require 'nokogiri'

module XNinja
  class Client
    def initialize()
      @document = Nokogiri::HTML(open("http://www.xvideos.com/"))
    end

    def document
      @document
    end

    def top
      @document.css("div.thumbInside").select{ |n|
        n.css('div a').count > 0 
      }.map{ |entry|
        title = entry.css("p a").first.attribute("title").value
        url = entry.css("p a").first.attribute("href").value
        thumbnail = entry.css("img").first.attribute("src").value
        {:title => title, :url => url, :thumbnail => thumbnail }
      }
    end
  end
end
