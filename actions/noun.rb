module Actions
  class Noun
    attr_reader :noun, :nsfw

    module NSFW
      WORK_INAPPROPRIATE = /boob|tit|cock|penis|vagina|pussy|dick|ass|fuck|shit|piss|sex|gay|lesbian|chick/
      def nsfw?
        true
      end

      def self.nsfw?(noun)
        noun =~ WORK_INAPPROPRIATE
      end
    end

    module BlackListed
      BLACKLIST = ["selinaferguson", "pwaring",'eddsowden','shakarshy','nickbrom', 'julietuesley','andrewbrin','dtox','abigailwessel', 'abby', 'angelaparriott', 'elizabethparriott']
      def file
        Struct.new(:file, :max_age).new('./copyrightcomplaint.jpg',36000)
      end

      def self.blacklisted?(noun)
        noun.downcase!
        noun.gsub!(/[^\w]*/,'')
        BLACKLIST.include?(noun)
      end
    end

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
