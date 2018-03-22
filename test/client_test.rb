require "test_helper"

class SysproClientTest < Minitest::Test
  def test_get_syspro_version
    client = ::Syspro::SysproClient.new
    refute_nil client.get_syspro_version
  end
end
