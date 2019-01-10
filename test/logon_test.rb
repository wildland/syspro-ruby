# frozen_string_literal: true

require 'test_helper'

class LogonTest < Minitest::Test
  extend Minitest::Spec::DSL
  before { VCR.insert_cassette name }
  after { VCR.eject_cassette }

  let(:username) { ENV['SYSPRO_USERNAME'] }
  let(:password) { ENV['SYSPRO_PASSWORD'] }
  let(:company) { ENV['SYSPRO_COMPANY'] }
  let(:company_password) { '' }

  def test_logon
    assert_match(
      /([A-Z0-9]{33})\w/,
      ::Syspro::SysproClient.new.logon(
        username,
        password,
        company,
        company_password
      ).guid
    )
  end

  def test_logon_error
    assert_raises(::Syspro::AuthenticationError) {
      logon_result = ::Syspro::SysproClient.new.logon(
        username,
        'bad_password',
        company,
        company_password
      )
    }
  end
end
