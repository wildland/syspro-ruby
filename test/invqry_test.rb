# frozen_string_literal: true

require 'test_helper'

class InvQryTest < Minitest::Test
  extend Minitest::Spec::DSL
  # before { VCR.insert_cassette name }
  # after { VCR.eject_cassette }

  let(:username) { ENV['SYSPRO_USERNAME'] }
  let(:password) { ENV['SYSPRO_PASSWORD'] }
  let(:company) { ENV['SYSPRO_COMPANY'] }
  let(:company_password) { '' }

  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  def test_int_query
    invqry_req = Syspro::BusinessObjects::InvQry.new

    invqry_req.key_stock_code = 'YKMCNTF'
    invqry_req.filter_warehouse_list = 'H1'
    invqry_req.option = Syspro::BusinessObjects::Models::InvQryOptions.new
    invqry_req.option.include_lots = "Y"
    
    invqry_rsp = invqry_req.call(user_id.guid)
    binding.pry

    assert_equal 1, 1
    # assert_kind_of Syspro::BusinessObjects::Models::SorDetail, sor_result
  end
end