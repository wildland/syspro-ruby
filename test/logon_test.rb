require "test_helper"

class LogonTest < Minitest::Test
  def test_logon
    username = "wland"
    password = "piperita2016"
    company  = "L"
    company_password = ""
    client = ::Syspro::SysproClient.new

    assert_match (/([A-Z0-9]{33})\w/), client.logon(username, password, company, company_password).guid
  end
end

