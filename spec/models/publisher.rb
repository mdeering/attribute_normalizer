class Publisher < ActiveRecord::Base

  attr_accessor :custom_writer

  def name=(_)
    self.custom_writer = true
    super
  end

  normalize_attribute :name, :with => :blank

end
