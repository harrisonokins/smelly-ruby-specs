require 'sqlite3'
require 'test/unit'

Test::Unit.at_start do
  # Set up the database
  @db = SQLite3::Database.new "test.db"

  # Create a table
  @db.execute <<-SQL
    create table test_data (
      name varchar(30),
      val int
    );
  SQL
end

Test::Unit.at_exit do
  # Cleanup the test data
  @db.execute "drop table test_data"

  # Close the database
  @db.close
end
