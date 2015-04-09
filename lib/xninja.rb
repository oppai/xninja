require 'open-uri'
require 'nokogiri'

module XNinja
  class Client
    def initialize
      @useragent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4'
      @document = Nokogiri::HTML(open("http://www.xvideos.com/",  'User-Agent' => @useragent))
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

    def detail(param)
      @detail_doc = Nokogiri::HTML(open("http://www.xvideos.com#{param}",  'User-Agent' => @useragent))
      p @detail_doc
      url = @detail_doc.css('div#player a').last
      thumbnail = @detail_doc.css('div#player img').first.attribute('src').value
      title = @detail_doc.title
      {:url => nil, :thumbnail=> nil, :title=> nil}
    end
  end
end
