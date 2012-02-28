require 'cgi'
require 'timeout'
require 'open-uri'
require './actions/image/didntfindshit'

module Actions
  class Image
    AnnotationException = Class.new(Exception)

    attr_accessor :file, :max_age

    def initialize(noun)
      @noun    = noun
      @max_age = 36000
      @file    = nil
    end

    def fetch!
      @file = Image.fetch(@noun)
    end

    def annotate!
      @file = Image.annotate(@file,@noun)
    end

    def self.try_5_times
      count = 0
      begin
        yield
      rescue Exception => e
        count += 1
        count < 5 ? retry : raise(e)
      end
    end

    def self.create(noun=nil)
      instance = new(noun)

      noun or return instance.extend(Didntfindshit)
      count  = 0

      try_5_times do
        instance.fetch!
        instance.annotate!
      end rescue instance.extend(Didntfindshit)

      instance
    end

    def self.fetch(noun,source=Bing)
      images = source.fetch(noun)
      count  = 0

      try_5_times do
        Timeout::timeout(3) {
          return images.next
        }
      end
    end

    def self.annotate(img, noun, shirtastic=false)
      picture = Magick::Image.from_blob(img.read).first
      width,height = picture.columns, picture.rows

      if shirtastic
        factor = 2000/600.0
        if width > height
          picture.resize!(2000,2000*(height/width.to_f))
        else
          picture.resize!(2000*(width/height.to_f), 2000)
        end
      else
        factor = 1
        picture.resize!(600,600*(height/width.to_f))
      end
      width,height = picture.columns, picture.rows

      overlay = Magick::Image.new(width, 100 * factor)
      picture.composite!(overlay, Magick::SouthGravity, Magick::MultiplyCompositeOp)

      caption = Magick::Draw.new
      caption.fill('white')
      caption.stroke('black')
      caption.font_stretch = Magick::ExtraCondensedStretch
      caption.font('Helvetica-Bold')
      caption.stroke_width(2 * factor)
      caption.pointsize(48 * factor)
      caption.font_weight(800)
      caption.text_align(Magick::CenterAlign)

      caption.text(width/2.0, height-(50*factor), "FUCK YEAH\n#{noun.upcase}")
      caption.draw(picture)

      picture.to_blob { self.quality = 50 }

      tmp = Tempfile.new('asdf')
      tmp.write(picture.to_blob)
      tmp
    end
  end

end
