require 'rubygems'
require 'rspec'
require 'active_record'
require 'mongoid'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'attribute_normalizer'


AttributeNormalizer.configure do |config|

  config.normalizers[:currency] = lambda do |value, options|
    value.is_a?(String) ? value.gsub(/[^0-9\.]+/, '') : value
  end

  config.normalizers[:truncate] = lambda do |text, options|
    if text.is_a?(String)
      options.reverse_merge!(:length => 30, :omission => "...")
      l = options[:length] - options[:omission].mb_chars.length
      chars = text.mb_chars
      (chars.length > options[:length] ? chars[0...l] + options[:omission] : text).to_s
    else
      text
    end
  end

  config.normalizers[:special_normalizer] = lambda do |value, options|
    (value.is_a?(String) && value.match(/testing the default normalizer/)) ? 'testing the default normalizer' : value
  end

  config.default_normalizers = :strip, :special_normalizer, :blank
  config.default_attributes = :name, :title
  config.add_default_attribute :authors, :strip => true, :blank => true

end


require 'connection_and_schema'
require 'models/book'
require 'models/author'
require 'models/journal'
require 'models/article'
require 'models/magazine'


RSpec.configure do |config|
  config.include AttributeNormalizer::RSpecMatcher
end
