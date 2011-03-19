module AttributeNormalizer

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def normalize_attributes(*attributes, &block)
      normalizers = attributes.last.is_a?(::Hash) ? attributes.pop : {}
      
      if normalizers.empty? && !block_given?
        normalizers = AttributeNormalizer.configuration.default_normalizers # the default normalizers
      end

      attributes.each do |attribute|
        if block_given?
          define_method "normalize_#{attribute}" do |value|
            yield(value)
          end
        else
          define_method "normalize_#{attribute}" do |value|
            normalized = value
            
            normalizers.each do |key, options|
              normalizer = AttributeNormalizer.configuration.normalizers[key]
              raise AttributeNormalizer::MissingNormalizer.new("No normalizer was found for #{key}") unless normalizer

              normalized = if normalizer.respond_to?(:normalize)
                normalizer.normalize(normalized, TrueClass === options ? {} : options)
              else
                normalizer.call(normalized, TrueClass === options ? {} : options)
              end
            end
            normalized
          end
        end

        self.send :private, "normalize_#{attribute}"

        define_method "#{attribute}=" do |value|
          super(self.send(:"normalize_#{attribute}", value))
        end

      end
    end
    alias :normalize_attribute :normalize_attributes

    def normalize_default_attributes
      AttributeNormalizer.configuration.default_attributes.each do |attribute_name, options| 
        normalize_attribute(attribute_name, options) if self.column_names.include?(attribute_name)
      end
    end

    def inherited(subclass)
      super
      subclass.normalize_default_attributes if subclass.table_exists?
    end
  end
end
