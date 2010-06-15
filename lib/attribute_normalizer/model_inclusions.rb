module AttributeNormalizer

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def normalize_attributes(*attributes, &block)
      options = attributes.extract_options!
      normalizers    = [options.delete(:with)].flatten.compact
      if normalizers.empty? && !block_given?
        normalizers=[:strip,:blank] #the default normalizers
      end
      
      attributes.each do |attribute|
        define_method "normalize_#{attribute}" do |value|
          if block_given?
            yield(value)
          else
            normalized=value
            normalizers.each do |normalizer_name|
              unless normalizer_name.kind_of?(Symbol)
                normalizer_name,options=normalizer_name.keys[0],normalizer_name[normalizer_name.keys[0]]
              end

              unless AttributeNormalizer.configuration.normalizers.has_key?(normalizer_name)
                raise AttributeNormalizer::MissingNormalizer.new("No normalizer was found for #{normalizer_name}")
              end
              normalizer=AttributeNormalizer.configuration.normalizers[normalizer_name]

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
  end
end
