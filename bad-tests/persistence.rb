require_relative '../test_helper.rb'
require_relative '../models/user'

class BadTests
  class Persistence < Test::Unit::TestCase
    def self.startup
      # Create a table to store user data
        DB.connection.execute <<-SQL
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER NOT NULL PRIMARY KEY,
          name TEXT,
          views INTEGER DEFAULT 0,
          most_popular BOOLEAN DEFAULT false
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

    def test_user_finder
      user = ::User.find(1)
      assert_equal user.id, 1
      assert_equal user.name, 'Féolcain Dorean'
    end
  end
end
