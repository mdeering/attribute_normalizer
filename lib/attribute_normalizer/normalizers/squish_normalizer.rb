module AttributeNormalizer
  module Normalizers
    module SquishNormalizer
      extend BaseNormalizer

      def self.perform_normalization(value)
        value.strip.gsub(/\s+/, ' ')
      end
    end
  end
end
