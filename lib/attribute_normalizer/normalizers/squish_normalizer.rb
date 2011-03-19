module AttributeNormalizer
  module Normalizers
    module SquishNormalizer
      def self.normalize(value, options = {})
        value.is_a?(String) ? value.strip.gsub(/\s+/, ' ') : value
      end
    end
  end
end