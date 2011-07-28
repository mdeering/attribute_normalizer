class Magazine

  include AttributeNormalizer

  attr_accessor        :name,
                       :cnd_price,
                       :us_price,
                       :summary,
                       :title

  normalize_attributes :name
  normalize_attribute  :us_price, :cnd_price, :with => :currency

  normalize_attributes :summary,
                       :with => [
                         :strip,
                         { :truncate => { :length => 12 } },
                         :blank
                        ]

  normalize_attributes :title do |value|
    value.is_a?(String) ? value.titleize.strip : value
  end

end