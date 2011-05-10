require File.dirname(File.expand_path(__FILE__)) + '/test_helper'

describe AttributeNormalizer do

  it 'should add the class method Class#normalize_attributes and Class#normalize_attribute when included' do
    klass = Class.new do
      include AttributeNormalizer
    end

    klass.should respond_to(:normalize_attributes)
    klass.should respond_to(:normalize_attribute)
  end

end