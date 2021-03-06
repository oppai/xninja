require 'open-uri'
require 'nokogiri'
require 'uri'
require 'base64'

module XNinja
  class Client
    def initialize
      @useragent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4'
      @base_url  = 'http://jp.xvideos.com'
    end

    attr_reader :document

    def top(num = 0)
      return list("/new/#{num}/") if num.to_i > 0
      list
    end

    def search(word, num = 0)
      return list("/?k=#{word}&p=#{num}") if num.to_i > 0
      list("/?k=#{word}")
    end

    def detail(param)
      formated_param = Base64.decode64(param).gsub(%r{/[0-9]+/}, '/')
      detail_doc = Nokogiri::HTML(open("#{@base_url}#{formated_param}",  'User-Agent' => @useragent))
      nominator =  URI.extract(detail_doc.css('div#content script').text.gsub(/\'/, ' ')).uniq
      high = low = thumb = nil
      nominator.each do |node|
        high = node if /mp4/ =~ node
        low = node if /3gp/ =~ node
        thumb = node if /jpg/ =~ node
      end
      { high: high, low: low, thumbnail: thumb, title: detail_doc.title }
    end

    private

    def list(path = '')
      movie_thums(path).map do |entry|
        title = entry.css('p a').first.inner_text
        url = entry.css('p a').first.attribute('href').value
        thumbnail = entry.css('img').first.attribute('src').value
        { title: title, url: Base64.encode64(url), thumbnail: thumbnail }
      end
    end

    def movie_thums(path)
      escaped_path = URI.escape(path)
      document = Nokogiri::HTML(open("#{@base_url}/#{escaped_path}",  'User-Agent' => @useragent))
      document.css('div.thumbInside').select do |n|
        n.css('p a').size > 0
      end
    end
  end
end
