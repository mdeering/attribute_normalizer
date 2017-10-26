module AttributeNormalizer
  module Normalizers
    module StripNormalizer
      # https://en.wikipedia.org/wiki/Whitespace_character#Unicode
      SPACE_CHAR_CLASS = '\p{Space}\u180e\u200b\u200c\u200d\u2060\ufeff'.freeze
      SPACE_REGEX = %r{\A[#{SPACE_CHAR_CLASS}]+|[#{SPACE_CHAR_CLASS}]+\z}.freeze

      def self.normalize(value, options = {})
        if value.is_a?(String)
          if value.encoding == Encoding::UTF_8
            value.gsub(SPACE_REGEX, '')
          else
            value.strip
          end
        else
          value
        end
      end
    end
  end
end
