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
            @#{attribute} ||= self.class.send(:normalize_#{attribute}, self[:#{attribute}]) unless self[:#{attribute}].nil?
          end

          def #{attribute}=(#{attribute})
            @#{attribute} = self[:#{attribute}] = self.class.send(:normalize_#{attribute}, #{attribute})
          end
        end_src

        module_eval src, __FILE__, __LINE__

      end

    end
  end
end
