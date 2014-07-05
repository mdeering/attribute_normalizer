module AttributeNormalizer
  module Normalizers
    module PhoneNormalizer
      extend BaseNormalizer

      def self.perform_normalization(value)
        value = value.gsub(/[^0-9]+/, '')
        value.empty? ? nil : value
      end
    end
  end
end
