class Author < ActiveRecord::Base

  normalize_attribute :name
  normalize_attribute :nickname,     :with => :squish
  normalize_attribute :first_name,   :with => :strip
  normalize_attribute :last_name,    :with => :blank

end