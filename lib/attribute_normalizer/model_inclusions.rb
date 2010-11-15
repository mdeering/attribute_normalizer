module AttributeNormalizer

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def normalize_attributes(*attributes, &block)
      options = attributes.last.is_a?(::Hash) ? attributes.pop : {}

      normalizers    = [options.delete(:with)].flatten.compact
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
            normalized=value
            normalizers.each do |normalizer_name|
              unless normalizer_name.kind_of?(Symbol)
                normalizer_name,options=normalizer_name.keys[0],normalizer_name[normalizer_name.keys[0]]
              end

              normalizer=AttributeNormalizer.configuration.normalizers[normalizer_name]
              raise AttributeNormalizer::MissingNormalizer.new("No normalizer was found for #{normalizer_name}") unless normalizer

              normalized= normalizer.respond_to?(:normalize) ? normalizer.normalize(normalized,options) :
                normalizer.call(normalized, options)
              #puts "#{normalizer_name} : ->'#{normalized}' (#{normalized.class})"
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
      subclass.normalize_default_attributes
    end
  end
end
