class Book < ActiveRecord::Base

  normalize_attribute  :author  #the default normalizers are :strip,:blank

  normalize_attribute  :price, :with => :currency

  normalize_attributes :summary, :with => [:strip,{:truncate => {:length => 12}}, :blank]

  
  normalize_attributes :title do |value|
    value.is_a?(String) ? value.titleize.strip : value
  end

end