require File.dirname(File.expand_path(__FILE__)) + '/test_helper'

describe Author do

  context 'Testing the built in normalizers' do
    # default normalization [ :strip, :blank ]
    it { should normalize_attribute(:name) }
    it { should normalize_attribute(:name).from(' this ').to('this') }
    it { should normalize_attribute(:name).from('   ').to(nil) }

    # :strip normalizer
    it { should normalize_attribute(:first_name).from('  this  ').to('this') }
    it { should normalize_attribute(:first_name).from('    ').to('') }

    # :squish normalizer
    it { should normalize_attribute(:nickname).from(' this    nickname  ').to('this nickname') }

    # :blank normalizer
    it { should normalize_attribute(:last_name).from('').to(nil) }
    it { should normalize_attribute(:last_name).from('  ').to(nil) }
    it { should normalize_attribute(:last_name).from(' this ').to(' this ') }

    # :whitespace normalizer
    it { should normalize_attribute(:biography).from("  this    line\nbreak ").to("this line\nbreak") }
    it { should normalize_attribute(:biography).from("\tthis\tline\nbreak ").to("this line\nbreak") }
    it { should normalize_attribute(:biography).from("  \tthis  \tline  \nbreak \t  \nthis").to("this line\nbreak\nthis") }
    it { should normalize_attribute(:biography).from('    ').to('') }
  end

  context 'on default attribute with the default normalizer changed' do
    it { should normalize_attribute(:phone_number).from('no-numbers-here').to(nil) }
    it { should normalize_attribute(:phone_number).from('1.877.987.9875').to('18779879875') }
    it { should normalize_attribute(:phone_number).from('+ 1 (877) 987-9875').to('18779879875') }
  end

end
