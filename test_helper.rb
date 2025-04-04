require 'pry'
require 'sqlite3'
require 'test/unit'

module DB
  @@db = nil
  
  def self.connection
    @@db
  end
  
  def self.connection=(db)
    @@db = db
  end
end

Test::Unit.at_start do
  # Set up the database
  DB.connection = SQLite3::Database.new 'test.db'
end

Test::Unit.at_exit do
  # Close the database
  DB.connection.close
end
