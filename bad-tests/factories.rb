require_relative '../test_helper.rb'
require_relative '../models/user'
require_relative '../bad-factories/user'

class BadTests
  class Factories < Test::Unit::TestCase
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

    def test_standard_user
      user = ::BadFactories::User.build(:standard)

      assert_equal user.name, 'Standard User'
      assert_false user.most_popular
    end

    def test_admin_user
      user = ::BadFactories::User.build(:admin)

      assert_equal user.name, 'Super User'
      assert_false user.most_popular
    end

    def test_popular_user
      user = ::BadFactories::User.build(:popular)

      assert_equal user.name, 'Popular User'
      assert_true user.views > 500
      assert_true user.most_popular
    end
  end
end
