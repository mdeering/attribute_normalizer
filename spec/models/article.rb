class Article < ActiveRecord::Base

  normalize_attribute :slug, :with => [ :strip, :blank ] do |value|
    value.present? && value.is_a?(String) ? value.downcase.gsub(/\s+/, '-') : value
  end

  normalize_attribute :limited_slug, :before => [ :strip, :blank ], :after => [ { :truncate => { :length => 11, :omission => '' } } ] do |value|
    value.present? && value.is_a?(String) ? value.downcase.gsub(/\s+/, '-') : value
  end

end
