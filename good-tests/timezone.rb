require_relative '../test_helper.rb'

class GoodTests
  class TimezoneTest < Test::Unit::TestCase
    def setup
      # Save the original timezone for later
      @original_timezone = ENV['TZ']

      # Set the timezone to UTC for these tests
      # (note that this is not thread-safe)
      ENV['TZ'] = 'UTC'
    end

    def teardown
      # Reset the timezone
      ENV['TZ'] = @original_timezone
    end

    def test_start_of_year
      start_of_year = Time.new(2025, 1, 1)
      assert_equal start_of_year.year, 2025
      assert_equal start_of_year.month, 1
      assert_equal start_of_year.day, 1
      assert_equal start_of_year.zone, 'UTC'
    end
  end
end
