require File.dirname(__FILE__) + '/test_helper'

describe AttributeNormalizer do

  it 'should add the class method Class#normalize_attributes and Class#normalize_attribute when included' do

    klass = Class.new do
      include AttributeNormalizer
    end

    klass.respond_to?(:normalize_attributes).should be_true
    klass.respond_to?(:normalize_attribute).should  be_true
  end

end
