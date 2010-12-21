module AttributeNormalizer

  module RSpecMatcher

    def normalize_attribute(attribute)
      NormalizeAttribute.new(attribute)
    end

    class NormalizeAttribute

      def initialize(attribute)
        @attribute = attribute
        @from = ''
      end

      def description
        "normalize #{@attribute} from #{@from.nil? ? 'nil' : "\"#{@from}\""} to #{@to.nil? ? 'nil' : "\"#{@to}\""}"
      end

      def failure_message
        "#{@attribute} did not normalize as expected! \"#{@subject.send(@attribute)}\" != #{@to.nil? ? 'nil' : "\"#{@to}\""}"
      end

      def negative_failure_message
        "expected #{@attribute} to not be normalized from #{@from.nil? ? 'nil' : "\"#{@from}\""} to #{@to.nil? ? 'nil' : "\"#{@to}\""}"
      end

      def from(value)
        @from = value
        self
      end

      def to(value)
        @to = value
        self
      end

      def matches?(subject)
        @subject = subject
        @subject.send("#{@attribute}=", @from)

        @subject.send(@attribute) == @to
      end

    end

  end

end
