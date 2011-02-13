class Author < ActiveRecord::Base

  normalize_attribute :name
  normalize_attribute :first_name,   :strip => true
  normalize_attribute :last_name,    :blank => true
  normalize_attribute :phone_number, :phone => true

end