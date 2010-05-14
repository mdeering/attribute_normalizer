class Book < ActiveRecord::Base

  normalize_attribute  :author

  normalize_attribute  :price, :with => :currency

  normalize_attributes :summary, :with => :truncate, :length => 12

  normalize_attributes :title do |value|
    value.is_a?(String) ? value.titleize.strip : value
  end

end