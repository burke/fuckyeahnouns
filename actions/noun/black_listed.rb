module Actions
  class Noun
    module BlackListed
      BLACKLIST = ["selinaferguson", "pwaring",'eddsowden','shakarshy','nickbrom', 'julietuesley','andrewbrin','dtox','abigailwessel', 'abby', 'angelaparriott', 'elizabethparriott']
      def file
        Struct.new(:file, :max_age).new('./public/copyrightcomplaint.jpg',36000)
      end

      def self.blacklisted?(noun)
        noun = noun.dup
        noun.downcase!
        noun.gsub!(/[^\w]*/,'')
        BLACKLIST.include?(noun)
      end
    end
  end
end
