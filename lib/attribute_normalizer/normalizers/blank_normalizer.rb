module AttributeNormalizer
  module Normalizers
    module BlankNormalizer
      def self.normalize(value, options = {})
        value.nil? || (value.is_a?(String) && value !~ /\S/) ? nil : value
      end
    end
  end
end