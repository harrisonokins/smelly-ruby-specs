require_relative '../test_helper.rb'
require_relative '../models/user'
require_relative '../good-factories/user'

class GoodTests
  class Factories < Test::Unit::TestCase
    def test_standard_user
      user = ::GoodFactories::User.build(:standard)

      assert_equal user.name, 'Standard User'
      assert_false user.most_popular
    end

    def test_admin_user
      user = ::GoodFactories::User.build(:admin)

      assert_equal user.name, 'Super User'
      assert_false user.most_popular
    end

    def test_popular_user
      user = ::GoodFactories::User.build(:popular)

      assert_equal user.name, 'Popular User'
      assert_true user.views > 500
      assert_true user.most_popular
    end
  end
end
