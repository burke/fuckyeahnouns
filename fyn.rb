require 'open-uri'
require 'json'
require 'cgi'
require 'RMagick'
require 'sinatra/base'

module FuckYeahNouns

  class Application < Sinatra::Base

    set :public, File.dirname(__FILE__) + '/public'

    get '/' do
      erb :home
    end 

    get '/:noun' do
      idx = params[:idx] || 0
      path = FuckYeahNouns.fuck_noun(params[:noun])
      "<html><body><img src='#{path}'/></body></html>"
    end 
    
  end 

  def self.fuck_noun(noun)
    try_path = "/images/#{noun.gsub(/[^A-Za-z0-9_\-]/,'')}.jpg"
    if File.exist?("public#{try_path}")
      return try_path
    end 

    img = FuckYeahNouns.fetch_image(noun)
    path = FuckYeahNouns.annotate(img, noun)
    return path
  end 
  
  def self.fetch_image(noun, idx=0)
    url = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{CGI.escape noun}"
    res = JSON.parse(open(url).read)
    imgdata = res['responseData']['results'][idx]
    open(imgdata['unescapedUrl'])
  end 

  def self.annotate(img, noun)
    picture = Magick::Image.from_blob(img.read).first
    width,height = picture.columns, picture.rows
    picture.resize!(600,600*(height/width.to_f))
    width,height = picture.columns, picture.rows

    overlay = Magick::Image.new(width, 100)
    picture.composite!(overlay, Magick::SouthGravity, Magick::MultiplyCompositeOp)

    caption = Magick::Draw.new
    caption.fill('white')
    caption.stroke('black')
    caption.stroke_width(2)
    caption.pointsize(48)
    caption.font_weight(900)
    caption.text_align(Magick::CenterAlign)

    caption.text(width/2.0, height-50, "FUCK YEAH\n#{noun.upcase}")
    caption.draw(picture)

    path = "/images/#{noun.gsub(/[^A-Za-z0-9_\-]/,'')}.jpg"
    picture.write("public#{path}")
    return path
  end 
  
end 

