require_relative '../test_helper.rb'

class BadTests
  class Seeds < Test::Unit::TestCase
    def test_users
      users = DB.connection.execute 'SELECT * FROM users'
      assert_equal users.length, 1
    end
  end
end
