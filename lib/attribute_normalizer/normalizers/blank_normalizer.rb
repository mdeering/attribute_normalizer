module AttributeNormalizer
  module Normalizers
    module BlankNormalizer
      extend BaseNormalizer
      def self.normalize(value, options = {})
        val = super
        val.reject!{|v| v.nil?} if val.is_a? Array
        val
      end

      def self.perform_normalization(value)
        value !~ /\S/ ? nil : value
      end
    end
  end
end
