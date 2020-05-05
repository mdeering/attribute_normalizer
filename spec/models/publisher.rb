class Publisher < ActiveRecord::Base

  attr_accessor :custom_writer

  def name=(_)
    self.custom_writer = true
    super
  end

  normalize_attribute :name,         :with => :blank
  normalize_attribute :phone_number, :with => :phone

  normalize_attribute :international_phone_number do |number|
    self.country == 'fr' ? number.sub(/^0/,'+33') : number
  end

end
