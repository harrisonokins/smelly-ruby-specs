require_relative '../test_helper.rb'

class GoodTests
  class Seeds < Test::Unit::TestCase
    def self.startup
      # Create a table to store user data
        DB.connection.execute <<-SQL
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER NOT NULL PRIMARY KEY,
          name TEXT
        )
      SQL

      # Seed the table with some data
      DB.connection.execute <<-SQL
        INSERT INTO users (id, name)
        VALUES (1, "Féolcain Dorean"),
               (2, "Aelith Dorean"),
               (3, "Caelum Dorean")
      SQL
    end

    def self.shutdown
      # Cleanup the test data
      DB.connection.execute 'DROP TABLE users'
    end

    def test_users
      users = DB.connection.execute 'SELECT * FROM users'
      assert_equal users.length, 3
    end
  end
end
