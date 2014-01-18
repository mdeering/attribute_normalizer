module AttributeNormalizer
  module Normalizers
    module StripNormalizer
      extend BaseNormalizer

      def self.perform_normalization(value)
        value.strip
      end
    end
  end
end
