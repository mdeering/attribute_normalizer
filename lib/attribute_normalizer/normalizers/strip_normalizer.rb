module AttributeNormalizer
  module Normalizers
    module StripNormalizer
      def self.normalize(value, options = {})
        value.is_a?(String) ? value.strip : value
      end
    end
  end
end