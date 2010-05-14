ActiveRecord::Base.establish_connection({ :database => ":memory:", :adapter => 'sqlite3', :timeout => 500 })

ActiveRecord::Schema.define do
  create_table :books, :force => true do |t|
    t.string  :author
    t.string  :isbn
    t.decimal :price
    t.string  :summary
    t.string  :title
  end
end