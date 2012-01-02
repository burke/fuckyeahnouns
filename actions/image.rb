module Actions
  class Image
    attr_accessor :file, :max_age

    def initialize(noun)
      @noun    = noun
      @max_age = 36000
      @file    = nil
    end

    def fetch
      @file = FuckYeahNouns.fetch_image(noun)
      FuckYeahNouns.annotate(@file, noun, shirtastic)
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
  end

  module Didntfindshit

    def file
      './didntfindshit.jpg'
    end

    def max_age
      30
    end
  end
end
