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

  # Create a table
  DB.connection.execute <<-SQL
    CREATE TABLE users(
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT
    )
  SQL
end

Test::Unit.at_exit do
  # Cleanup the test data
  DB.connection.execute 'DROP TABLE users'

  # Close the database
  DB.connection.close
end
