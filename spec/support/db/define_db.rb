ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
    t.timestamps
  end

  create_table :user_books, force: true do |t|
    t.references :user
    t.references :book
    t.timestamps
  end

  create_table :books, force: true do |t|
    t.string :name
    t.references :genre
    t.references :author

    t.timestamps
  end

  create_table :genres, force: true do |t|
    t.string :name

    t.timestamps
  end

  create_table :authors, force: true do |t|
    t.string :name

    t.timestamps
  end
end