module Actions
  class Noun
    BLACKLIST = ["selinaferguson", "pwaring",'eddsowden','shakarshy','nickbrom', 'julietuesley','andrewbrin','dtox','abigailwessel', 'abby', 'angelaparriott', 'elizabethparriott']
    WORK_INAPPROPRIATE = /boob|tit|cock|penis|vagina|pussy|dick|ass|fuck|shit|piss|sex|gay|lesbian|chick/
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

      instance.extend(BlackListed) if black_listed?(noun)
      instance.extend(NSFW)        if nsfw?(noun)

      instance
    end

    def self.black_listed?(noun)
      noun.downcase!
      noun.gsub!(/[^\w]*/,'')
      BLACKLIST.include?(noun)
    end

     def self.nsfw?(noun)
       noun =~ WORK_INAPPROPRIATE
     end
  end

  module NSFW
    def nsfw?
      true
    end
  end

  module BlackListed
    def file
      Struct.new(:file, :max_age).new('./copyrightcomplaint.jpg',36000)
    end
  end
end
