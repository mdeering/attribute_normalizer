module AttributeNormalizer
  module Normalizers
    module WhitespaceNormalizer
      def self.normalize(value, options = {})
        value.is_a?(String) ? value.strip.gsub(/[^\S\n]+/, ' ') : value
      end
    end
  end
end