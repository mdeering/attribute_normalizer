require 'attribute_normalizer/normalizers/blank_normalizer'
require 'attribute_normalizer/normalizers/phone_normalizer'
require 'attribute_normalizer/normalizers/strip_normalizer'
require 'attribute_normalizer/normalizers/squish_normalizer'

module AttributeNormalizer

  class MissingNormalizer < ArgumentError; end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end


  class Configuration
    attr_accessor :default_normalizers, :normalizers, :default_attributes

    def default_normalizers=(normalizers)
      @default_normalizers = normalizers.is_a?(Array) ? normalizers : [ normalizers ]
    end

    def default_attributes=(attributes)
      [attributes].flatten.each do |attribute|
        add_default_attribute(attribute, :with => default_normalizers)
      end
    end

    def add_default_attribute(attribute, options)
      @default_attributes[attribute.to_s] = { :with => default_normalizers }.merge(options)
    end

    def initialize
      @normalizers = {}
      @normalizers[ :blank ]   = AttributeNormalizer::Normalizers::BlankNormalizer
      @normalizers[ :phone ]   = AttributeNormalizer::Normalizers::PhoneNormalizer
      @normalizers[ :strip ]   = AttributeNormalizer::Normalizers::StripNormalizer
      @normalizers[ :squish ]  = AttributeNormalizer::Normalizers::SquishNormalizer
      @default_normalizers = [ :strip, :blank ]
      @default_attributes = {}
    end


  end

end


require 'attribute_normalizer/model_inclusions'
require 'attribute_normalizer/rspec_matcher'

def include_attribute_normalizer(class_or_module)
  return if class_or_module.include?(AttributeNormalizer)
  class_or_module.class_eval do
    extend AttributeNormalizer::ClassMethods
  end
end



include_attribute_normalizer(ActiveModel::Base)     if defined?(ActiveModel::Base)
include_attribute_normalizer(ActiveRecord::Base)    if defined?(ActiveRecord::Base)
include_attribute_normalizer(CassandraObject::Base) if defined?(CassandraObject::Base)

if defined?(Mongoid::Document)
  Mongoid::Document.class_eval do
    included do
      include AttributeNormalizer
    end
  end
end