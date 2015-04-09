require 'open-uri'
require 'nokogiri'
require 'uri'
require 'base64'

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
        {:title => title, :url => Base64.encode64(url), :thumbnail => thumbnail }
      }
    end

    def detail(param)
      formated_param = Base64.decode64(param).gsub(/\/[0-9]+\//, '/')
      @detail_doc = Nokogiri::HTML(open("http://www.xvideos.com#{formated_param}",  'User-Agent' => @useragent))
      nominator =  URI.extract(@detail_doc.css('div#content script').text.gsub(/\'/, ' ')).uniq
      high = low = thumb = nil
      nominator.each do |node|
        high = node if /mp4/ =~ node
        low = node if /3gp/ =~ node
        thumb = node if /jpg/ =~ node
      end
      {:high => high, :low => low, :thumbnail => thumb, :title => @detail_doc.title}
    end
  end
end
