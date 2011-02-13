class Book < ActiveRecord::Base

  normalize_attribute  :author

  normalize_attribute  :us_price, :cnd_price, :currency => true

  normalize_attributes :summary, :strip => true, :truncate => { :length => 12 }, :blank => true

  normalize_attributes :title do |value|
    value.is_a?(String) ? value.titleize.strip : value
  end

end