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


ActiveRecord::Base.class_eval    { include AttributeNormalizer } if defined?(ActiveRecord::Base)
CassandraObject::Base.class_eval { include AttributeNormalizer } if defined?(CassandraObject::Base)
