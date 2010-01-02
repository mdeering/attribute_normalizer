require 'rubygems'
require 'spec'
require 'activesupport'
require 'activerecord'

ActiveRecord::Base.establish_connection({ :database => ":memory:", :adapter => 'sqlite3', :timeout => 500 })

ActiveRecord::Schema.define do
  create_table :users, :force => true do |t|
    t.string :name
  end
end

class User < ActiveRecord::Base; end

Spec::Runner.configure do |config|
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
