require_relative '../test_helper.rb'

class GoodTests
  class Leftovers < Test::Unit::TestCase
    def setup
      # Create a table to store user data
      # (unless it already exists)
        DB.connection.execute <<-SQL
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER NOT NULL PRIMARY KEY,
          name TEXT
        )
      SQL
    end

    def teardown
      # Cleanup the test data
      DB.connection.execute 'DROP TABLE users'
    end

    def test_user_creation
      result = DB.connection.execute 'INSERT INTO users (id, name) values (1, "Féolcain Dorean")'
      users = DB.connection.execute 'SELECT * FROM users'
      assert_equal users.length, 1
    end
  end
end
