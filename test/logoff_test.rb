# frozen_string_literal: true

require 'test_helper'

class LogoffTest < Minitest::Test
  extend Minitest::Spec::DSL
  before { VCR.insert_cassette name }
  after { VCR.eject_cassette }

  let(:username) { 'wland' }
  let(:password) { 'piperita2016' }
  let(:company) { 'L' }
  let(:company_password) { '' }

  def test_successful_logoff
    uid = Syspro::Logon.logon(username, password, company, company_password)
    assert_equal true, Syspro::Logoff.logoff(uid.guid)
  end

  def test_logoff_error
    assert_kind_of(
      String,
      Syspro::Logoff.logoff('1BB5B3050954BB459A5D034DB5CC386980')
    )
  end
end
