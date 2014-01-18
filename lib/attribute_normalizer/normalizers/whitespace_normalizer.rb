module AttributeNormalizer
  module Normalizers
    module WhitespaceNormalizer
      extend BaseNormalizer

      def self.perform_normalization(value)
        value.gsub(/[^\S\n]+/, ' ').gsub(/\s?\n\s?/, "\n").strip
      end
    end
  end
end
