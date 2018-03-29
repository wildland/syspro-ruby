require "test_helper"

class SysproClientTest < Minitest::Test
  def test_get_syspro_version
    client = ::Syspro::SysproClient.new
    assert_match (/(\d+\.)?(\d+\.)?(\d+\.)?(\d+)/), client.get_syspro_version.version
  end
end
