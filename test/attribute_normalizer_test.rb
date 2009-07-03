require 'test_helper'

# TODO: It has been so dam long since I have done regular test unit.  Kill this test
# and replace it with RSpec.
class AttributeNormalizerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test 'including the module will add the class method Class#normalize_attributes' do
    klass = Class.new do
      include AttributeNormalizer
    end
    
    assert(klass.respond_to?(:normalize_attributes) == true)
  end

end
