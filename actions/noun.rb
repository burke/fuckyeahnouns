require './actions/noun/nsfw'
require './actions/noun/black_listed'

module Actions
  class Noun
    attr_reader :noun, :nsfw

    def initialize(noun)
      @noun = noun
    end

    def shirt
      @shirt ||= Shirt.create(noun)
    end

    def image
      @image ||= Image.create(noun)
    end

    def self.create(noun)

      instance = new(noun)

      instance.extend(BlackListed) if BlackListed.blacklisted?(noun)
      instance.extend(NSFW)        if NSFW.nsfw?(noun)

      instance
    end
  end
end
