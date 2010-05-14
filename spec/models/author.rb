class Author < ActiveModel::Base

  normalize_attribute  :name

  normalize_attribute  :hourly_cost, :with => :currency

  normalize_attributes :biography,   :with => :truncate, :length => 12

  normalize_attributes :email_address do |value|
    value.is_a?(String) ? value.titleize.strip : value
  end

end