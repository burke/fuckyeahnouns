module Actions
  class Noun
    module NSFW
      WORK_INAPPROPRIATE = /boob|tit|cock|penis|vagina|pussy|dick|ass|fuck|shit|piss|sex|gay|lesbian|chick/

      def self.enabled?
        @enabled
      end

      def self.enable!
        @enabled = true
      end

      def self.disable!
        @enabled = false
      end

      def nsfw?
        true
      end

      def image
        Struct.new(:file, :max_age).new('./public/didntfindshit.jpg',300)
      end

      def self.nsfw?(noun)
        noun =~ WORK_INAPPROPRIATE if enabled?
      end
    end
  end
end
