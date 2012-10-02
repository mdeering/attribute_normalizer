require File.dirname(File.expand_path(__FILE__)) + '/test_helper'

describe Publisher do

  context 'on default attribute with the default normalizer changed' do
    it { should normalize_attribute(:phone_number).from('no-numbers-here').to(nil) }
    it { should normalize_attribute(:phone_number).from('1.877.987.9875').to('18779879875') }
    it { should normalize_attribute(:phone_number).from('+ 1 (877) 987-9875').to('18779879875') }
  end

end
