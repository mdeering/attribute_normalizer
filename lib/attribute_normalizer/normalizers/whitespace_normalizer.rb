module AttributeNormalizer
  module Normalizers
    module WhitespaceNormalizer
      def self.normalize(value, options = {})
        value.is_a?(String) ? value.gsub(/[^\S\n]+/, ' ').gsub(/\s?\n\s?/, "\n").strip : value
      end
    end
  end
end
