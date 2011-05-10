require File.dirname(File.expand_path(__FILE__)) + '/test_helper'

describe Magazine do

  it do
    should normalize_attribute(:name).
      from(' Plain Old Ruby Objects ').to('Plain Old Ruby Objects')
  end

  it do
    should normalize_attribute(:us_price).from('$3.50').to('3.50')
  end

  it do
    should normalize_attribute(:cnd_price).from('$3,450.98').to('3450.98')
  end

  it do
    should normalize_attribute(:summary).
      from('    Here is my summary that is a little to long  ').
      to('Here is m...')
  end

  it do
    should normalize_attribute(:title).
      from('some really interesting title').
      to('Some Really Interesting Title')
  end

end