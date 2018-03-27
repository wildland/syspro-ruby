require "test_helper"

class SysproClientTest < Minitest::Test
  def test_get_syspro_version
    client = ::Syspro::SysproClient.new
    assert_match /(\d+\.)?(\d+\.)?(\d+\.)?(\d+)/, client.get_syspro_version[0].http_body
  end
end
