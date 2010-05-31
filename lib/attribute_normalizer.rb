module AttributeNormalizer

  class MissingNormalizer < ArgumentError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :normalizers
    def initialize
      @normalizers = {}
    end
  end

end

require 'attribute_normalizer/model_inclusions'
require 'attribute_normalizer/rspec_matcher'

module Mongoid
  module Normalizer
    def self.included(base)
      base.class_eval do
        include AttributeNormalizer
        def write_attribute(attribute, value)
          if respond_to?(:"normalize_#{ attribute }")
            super(attribute, self.send(:"normalize_#{ attribute }", value))
          else
            super
          end
        end
      end
    end
  end
end
