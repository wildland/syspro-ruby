# frozen_string_literal: true

require 'test_helper'

class SysproClientTest < Minitest::Test
  extend Minitest::Spec::DSL
  before { VCR.insert_cassette name }
  after { VCR.eject_cassette }

  let(:client) { ::Syspro::SysproClient.new }

  def test_get_syspro_version
    assert_match(
      /(\d+\.)?(\d+\.)?(\d+\.)?(\d+)/,
      client.get_syspro_version.version
    )
  end

  def test_client_block_execution
    version, resp = client.request do
      Syspro::GetVersion.get_version
    end

    assert_match(version.version, resp.http_body)
    assert_match(/(\d+\.)?(\d+\.)?(\d+\.)?(\d+)/, version.version)
  end
end
