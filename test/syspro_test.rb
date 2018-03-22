require "test_helper"

class SysproTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Syspro::VERSION
  end
end
