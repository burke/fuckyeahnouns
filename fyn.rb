require 'open-uri'
require 'json'
require 'cgi'
require 'RMagick'
require 'sinatra/base'

module FuckYeahNouns

  class Application < Sinatra::Base

    set :public, File.dirname(__FILE__) + '/public'

    get '/' do
      "Hi."
      # home page
    end 

    get '/:noun' do
      idx = params[:idx] || 0
      # something like...
      img = FuckYeahNouns.fetch_image(params[:noun], idx)
      path = FuckYeahNouns.annotate(img, params[:noun])
      "<html><body><img src='#{path}'/></body></html>"
    end 
    
  end 

  def self.fetch_image(noun, idx=0)
    url = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{CGI.escape noun}"
    res = JSON.parse(open(url).read)
    imgdata = res['responseData']['results'][idx]
    imgurl = imgdata['unescapedUrl']
    image = open(imgurl)
    image
  end 

  def self.annotate(img, noun)
    # Picture Section
    picture = Magick::Image.from_blob(img.read).first
    width,height = picture.columns, picture.rows
    picture.resize!(600,600*(height/width.to_f))
    width,height = picture.columns, picture.rows

    # Overlay Section
    overlay = Magick::Image.new(width, 100) {
      self.background_color = "rgba(0,0,0,0.0)"
    }

    
    # Combine them!
    picture.composite!(overlay, Magick::SouthGravity, Magick::MultiplyCompositeOp)

    # Text Section
    caption = Magick::Draw.new
    caption.fill('white')
    caption.fill_opacity(1.0)
    caption.stroke('black')
    caption.stroke_width(2)

    caption.pointsize(48)
    caption.font_family('impact')
    caption.font_weight(900)

    caption.text_align(Magick::CenterAlign)

    # Place the caption onto the composite image 
    caption.text(width/2.0, height-50, "FUCK YEAH\n#{noun.upcase}")
    caption.draw(picture)

    path = "/images/#{noun.gsub(/[^A-Za-z0-9_\-]/,'')}.jpg"
    out = "public#{path}"
    puts "Writing #{out}"
    picture.write(out)
    return path
  end 
  
end 

if __FILE__ == $0
#  noun = ARGV[0]
#  img = FuckYeahNouns.fetch_image(noun)
#  FuckYeahNouns.annotate(img, noun)
  FuckYeahNouns::Application.run!
end 
