require 'attribute_normalizer/normalizers/blank_normalizer'
require 'attribute_normalizer/normalizers/phone_normalizer'
require 'attribute_normalizer/normalizers/strip_normalizer'
require 'attribute_normalizer/normalizers/squish_normalizer'
require 'attribute_normalizer/normalizers/whitespace_normalizer'
require 'attribute_normalizer/normalizers/boolean_normalizer'

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

    def initialize

      @normalizers = {
        :blank      => AttributeNormalizer::Normalizers::BlankNormalizer,
        :phone      => AttributeNormalizer::Normalizers::PhoneNormalizer,
        :squish     => AttributeNormalizer::Normalizers::SquishNormalizer,
        :strip      => AttributeNormalizer::Normalizers::StripNormalizer,
        :whitespace => AttributeNormalizer::Normalizers::WhitespaceNormalizer,
        :boolean    => AttributeNormalizer::Normalizers::BooleanNormalizer
      }

      @default_normalizers = [ :strip, :blank ]

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
