require 'json'
class Bing

  def initialize(noun)
    @noun = noun
    @urls = []
    @result = nil
    @json   = nil
  end

  def self.fetch(noun)
    new(noun).best_image
  end

  def best_image
    search_url = Bing.search_url(@noun)
    @result    = Bing.process(Bing.open_json(search_url))
    @urls      = @result[:images]

    # cycle till we find a working image
    open(@urls.first)
  end


  def self.process(json)
    result = json["SearchResponse"]
    images = result["Image"]

    {
      total:  images['Total'],
      images: images['Results'].map { |image| image['MediaUrl'] }
    }
  end

  def self.search_url(noun)
    query = CGI.escape noun
    ENV['bing'] = '0DA7AB4A8F9C686A25B23945975F9CCF4E8D3592'
    "http://api.bing.net/json.aspx?AppId=#{ENV['bing']}&Query=#{query}&Sources=Image&Version=2.0&Market=en-us&Adult=Moderate&Image.Count=10&Image.Offset=0"
  end

  def self.open_json(url)
    open(url) do |fh|
      return JSON.parse(fh.read)
    end
  end
end
