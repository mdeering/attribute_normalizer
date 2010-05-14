require 'rubygems'
require 'spec'
require 'active_support'
require 'active_record'

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

end


require 'connection_and_schema'
require 'models/book'


Spec::Runner.configure do |config|
  config.include AttributeNormalizer::RSpecMatcher, :type => :models
end