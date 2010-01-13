module AttributeNormalizer

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def normalize_attributes(*attributes, &block)

      attributes.each do |attribute|

        klass = class << self; self end

        klass.send :define_method, "normalize_#{attribute}" do |value|
          value = value.strip if value.is_a?(String)
          normalized = block_given? && !value.blank? ? yield(value) : value
          normalized.nil? || (normalized.is_a?(String) && normalized == '') ? nil : normalized
        end

        klass.send :private, "normalize_#{attribute}"

        src = <<-end_src
          def #{attribute}
            value = super
            value.nil? ? value : self.class.send(:normalize_#{attribute}, value)
          end

          def #{attribute}=(value)
            super(self.class.send(:normalize_#{attribute}, value))
          end
        end_src

        module_eval src, __FILE__, __LINE__

      end

    end

    alias :normalize_attribute :normalize_attributes

  end
end

ActiveRecord::Base.send(:include, AttributeNormalizer)
