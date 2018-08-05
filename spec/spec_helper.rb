require "bundler/setup"

require 'sqlite3'
require 'active_record'

require 'support/db/define_db'

require 'support/models/application_record'
require 'support/models/user'
require 'support/models/book'
require 'support/models/genre'
require 'support/models/user_book'
require 'support/models/author'


require 'cascade_touch'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
