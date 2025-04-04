require 'logger'
require 'pry'
require 'sqlite3'
require 'test/unit'
require 'mocha/test_unit'

# Create a logfile
@log = Logger.new(File.open('debug.log', 'w'))

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

  # Log all SQL commands
  DB.connection.trace { |sql| @log.debug(sql) }
end

Test::Unit.at_exit do
  # Close the database
  DB.connection.close
end
