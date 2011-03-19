module AttributeNormalizer
  module Normalizers
    module PhoneNormalizer
      def self.normalize(value, options = {})
        value = value.is_a?(String) ? value.gsub(/[^0-9]+/, '') : value
        value.is_a?(String) && value.empty? ? nil : value
      end
    end
  end
end