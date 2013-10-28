# Extracted from ActiveRecord::ConnectionAdapters::Column
require 'set'

module AttributeNormalizer
  module Normalizers
    module BooleanNormalizer
      TRUE_VALUES = [true, 1, '1', 't', 'T', 'true', 'TRUE', 'on', 'ON'].to_set

      def self.normalize(value, options = {})
        if value.is_a?(String) && value.blank?
          nil
        else
          TRUE_VALUES.include?(value)
        end
      end
    end
  end
end
