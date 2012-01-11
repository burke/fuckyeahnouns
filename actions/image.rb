module Actions
  class Image
    module Didntfindshit

      def file
        './didntfindshit.jpg'
      end

      def max_age
        30
      end
    end

    attr_accessor :file, :max_age

    def initialize(noun)
      @noun    = noun
      @max_age = 36000
      @file    = nil
    end

    def fetch
      @file = Image.fetch_image(noun)
      Image.annotate(@file, noun, shirtastic)
    end

    def self.create(noun)
      instance = new(noun)

      begin
        instance.fetch
      rescue
        instance.extend(Didntfindshit)
      end

      instance
    end

    def self.fetch_image(noun, idx=0)
      url = "http://boss.yahooapis.com/ysearch/images/v1/#{CGI.escape noun}?appid=#{ENV['APP_ID']}"
      # url = "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{CGI.escape noun}"


      # seriously, seriously need to rewrite this clusterfuck. What am I thinking?
      # It's 2:30am. That's my excuse.
      retries = 1
      begin
        res = nil
        Timeout::timeout(4) do
          res = JSON.parse(open(url).read)
        end
      rescue Timeout::Error
        retries -= 1
        if retries >= 0
          retry
        else
          raise "omg"
        end
      end

      set = res['ysearchresponse']['resultset_images']
      raise if set.size.zero?
      begin
        r = nil
        Timeout::timeout(4) do
          r=open(set[0]['url'])
        end
        r
      rescue StandardError, Timeout::Error
        begin
          r = nil
          Timeout::timeout(4) do
            r=open(set[1]['url'])
          end
          r
        rescue Timeout::Error
          raise "omg"
        end
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

      return picture.to_blob
    end
  end

end
