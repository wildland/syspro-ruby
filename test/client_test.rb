require "test_helper"

class SysproClientTest < Minitest::Test
  def test_get_syspro_version
    client = ::Syspro::SysproClient.new
    assert_match (/(\d+\.)?(\d+\.)?(\d+\.)?(\d+)/), client.get_syspro_version.version
  end

  def test_client_block_execution
    client = ::Syspro::SysproClient.new

    version, resp = client.request {
      Syspro::GetVersion.get_version
    }

    assert_match version.version, resp.http_body
    assert_match (/(\d+\.)?(\d+\.)?(\d+\.)?(\d+)/), version.version
  end
end
