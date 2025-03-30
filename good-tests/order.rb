require_relative '../test_helper.rb'

class GoodTests
  class Order < Test::Unit::TestCase
    def self.startup
      # Create a table to store user data
        DB.connection.execute <<-SQL
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER NOT NULL PRIMARY KEY,
          name TEXT
        )
      SQL
    end

    def self.shutdown
      # Cleanup the test data
      DB.connection.execute 'DROP TABLE users'
    end

    def setup
      DB.connection.execute 'INSERT INTO users (id, name) values (1, "Féolcain Dorean")'
    end

    def teardown
      DB.connection.execute 'DELETE FROM users'
    end

    def test_users
      users = DB.connection.execute 'SELECT * FROM users'
      assert_equal users.length, 1
    end

    def test_name
      results = DB.connection.execute 'SELECT name FROM users'
      assert_true results.flatten.include? 'Féolcain Dorean'
    end
  end
end
