# frozen_string_literal: true

require 'test_helper'

class InvWhCtrlQryTest < Minitest::Test
  extend Minitest::Spec::DSL
  before do
    VCR.insert_cassette name
  end
  after { VCR.eject_cassette }

  let(:username) { ENV['SYSPRO_USERNAME'] }
  let(:password) { ENV['SYSPRO_PASSWORD'] }
  let(:company) { ENV['SYSPRO_COMPANY'] }
  let(:company_password) { '' }
  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  def test_inv_wh_ctrl_qry
    inv_wh_ctrl_qry = Syspro::BusinessObjects::InvWhCtrlQry.new

    inv_wh_ctrl_qry.return_rows = 30
    inv_wh_query = inv_wh_ctrl_qry.call(user_id.guid)

    assert_kind_of Syspro::BusinessObjects::Models::InvWhQry, inv_wh_query
    assert inv_wh_query.prev_key, 'has a previous key'
    assert inv_wh_query.next_key, 'has a next key'
    assert_includes [true, false], inv_wh_query.fwd
    assert_includes [true, false], inv_wh_query.back
    inv_wh_query.warehouses.each do |warehouse|
      assert_kind_of(
        Syspro::BusinessObjects::Models::InvWhQry::Warehouse,
        warehouse
      )
    end
  end
end
