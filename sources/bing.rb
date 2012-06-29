require 'json'
require 'open-uri'
require './sources/image_iterator'
require './sources/spice'

class Bing
  attr_reader :noun, :images, :result, :json
  include ImageIterator

  def initialize(noun)
    @noun = noun

    @images = []
    @result = nil
    @json   = nil
  end

  def self.fetch(noun)
    instance = new(noun)
    instance.search!
    instance
  end

  def search!
    @url    = Bing.search_url(@noun)
    @result = Bing.open_json(@url)
    @json   = Bing.process_json(@result)

    @images = @json[:images]

    nil
  end

  def self.process_json(json)
    result = json["SearchResponse"]
    images = result["Image"]

    {
      total:  images['Total'],
      images: images['Results'].map { |image| image['MediaUrl'] }
    }
  end

  def self.search_url(noun)
    query = CGI.escape(Spice.up(noun))
    ENV['bing'] = '0DA7AB4A8F9C686A25B23945975F9CCF4E8D3592'
    filter = if (rand(10)+1)%2 == 0
      "&Image.Filters=Face:Portrait"
    else
      ""
    end
    "http://api.bing.net/json.aspx?AppId=#{ENV['bing']}&Query=#{query}&Sources=Image&Version=2.0&Market=en-us&Adult=On&Image.Count=10&Image.Offset=0#{filter}"
  end

  def self.open_json(url)
    Kernel.open(url) do |fh|
      return JSON.parse(fh.read)
    end
  end

end
