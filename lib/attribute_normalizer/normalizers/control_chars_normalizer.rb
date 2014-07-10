module AttributeNormalizer
  module Normalizers
    module ControlCharsNormalizer
      def self.normalize(value, options = {})
        value.is_a?(String) ? value.gsub(/[[:cntrl:]&&[^[:space:]]]/, '') : value
      end
    end
  end
end
