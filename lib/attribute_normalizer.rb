module AttributeNormalizer

  class MissingNormalizer < ArgumentError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.included(base)
    base.extend ClassMethods
  end

  class Configuration

    attr_accessor :normalizers

    def initialize
      @normalizers = {}
    end

  end

  module ClassMethods

    def normalize_attributes(*attributes, &block)
      options = attributes.extract_options!

      attributes.each do |attribute|

        klass = class << self; self end

        klass.send :define_method, "normalize_#{attribute}" do |value|
          normalized = if block_given? && !value.blank?
            yield(value)
          elsif !options[:with].nil? && !value.blank?
            raise AttributeNormalizer::MissingNormalizer.new("No normalizer was found for #{options[:with]}") unless AttributeNormalizer.configuration.normalizers.has_key?(options[:with])
            this = AttributeNormalizer.configuration.normalizers[options.delete(:with)].call(value, options)
          else
             value.is_a?(String) ? value.strip : value
           end
          normalized.nil? || (normalized.is_a?(String) && normalized == '') ? nil : normalized
        end

        klass.send :private, "normalize_#{attribute}"

        src = <<-end_src
          def #{attribute}=(value)
            super(self.class.send(:normalize_#{attribute}, value))
          end
        end_src

        module_eval src, __FILE__, __LINE__

      end

    end

    alias :normalize_attribute :normalize_attributes

  end

  module RSpecMatcher

    def normalize_attribute(attribute)
      NormalizeAttribute.new(attribute)
    end

    class NormalizeAttribute

      def description
        "normalize #{@attribute} from #{@from.nil? ? 'nil' : "\"#{@from}\""} to #{@to.nil? ? 'nil' : "\"#{@to}\""}"
      end

      def failure_message
        "#{@attribute} did not normalize as expected! \"#{@subject.send(@attribute)}\" != #{@to.nil? ? 'nil' : "\"#{@to}\""}"
      end

      def from(value)
        @from = value
        self
      end

      def initialize(attribute)
        @attribute = attribute
        @from = ''
      end

      def matches?(subject)
        @subject = subject
        @subject.send("#{@attribute}=", @from)
        return false unless @subject.send(@attribute) == @to
        true
      end

      def to(value)
        @to = value
        self
      end

    end

  end

end

ActiveRecord::Base.send(:include, AttributeNormalizer)    if defined?(ActiveRecord::Base)
CassandraObject::Base.send(:include, AttributeNormalizer) if defined?(CassandraObject::Base)
