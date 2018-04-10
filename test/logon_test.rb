# frozen_string_literal: true

require 'test_helper'

class LogonTest < Minitest::Test
  extend Minitest::Spec::DSL
  before { VCR.insert_cassette name }
  after { VCR.eject_cassette }

  let(:username) { 'wland' }
  let(:password) { 'piperita2016' }
  let(:company) { 'L' }
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
end
