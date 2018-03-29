require "test_helper"

class LogoffTest < Minitest::Test
  def test_successful_logoff
    username = "wland"
    password = "piperita2016"
    company  = "L"
    company_password = ""

    uid = Syspro::Logon.logon(username, password, company, company_password)
    assert_equal true, Syspro::Logoff.logoff(uid.guid)
  end

  def test_logoff_error
    assert_kind_of String, Syspro::Logoff.logoff('1BB5B3050954BB459A5D034DB5CC386980')
  end
end

