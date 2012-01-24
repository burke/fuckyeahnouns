module Actions
  class Noun
    module NSFW
      WORK_INAPPROPRIATE = /boob|tit|cock|penis|vagina|pussy|dick|ass|fuck|shit|piss|sex|gay|lesbian|chick/

      def nsfw?
        true
      end

      def image
        Struct.new(:file, :max_age).new('./public/didntfindshit.jpg',300)
      end

      def self.nsfw?(noun)
        #noun =~ WORK_INAPPROPRIATE
        false
      end
    end
  end
end
