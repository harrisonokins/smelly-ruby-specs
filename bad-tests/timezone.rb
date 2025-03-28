require_relative '../test_helper.rb'

class BadTests
  class Timezone < Test::Unit::TestCase
    def test_start_of_year
      start_of_year = Time.new(2025, 1, 1)
      assert_equal start_of_year.year, 2025
      assert_equal start_of_year.month, 1
      assert_equal start_of_year.day, 1
      assert_equal start_of_year.zone, 'UTC'
    end
  end
end
