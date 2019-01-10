require 'test_helper'

class PorTest < Minitest::Test
  extend Minitest::Spec::DSL
  before { VCR.insert_cassette name }
  after { VCR.eject_cassette }

  let(:username) { 'wland' }
  let(:password) { 'Piperita2018' }
  let(:company) { 'L' }
  let(:company_password) { '' }
  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  #def test_por_transaction
    #portor = Syspro::BusinessObjects::PorTor.new

    #portor.transaction_date = "2006-04-08"
    #portor.ignore_warnings = "N"
    #portor.grn_matching_action = "A"
    #portor.allow_blank_supplier = "N"
    #portor.apply_if_entire_document_valid = "Y"
    #portor.validate_only = "N"
    #portor.manual_serial_transfers_allowed = "N"
    #portor.ignore_analysis = "Y"

    #por_result = portor.call(user_id.guid)
    #assert_kind_of Syspro::BusinessObjects::Models::Por
  #end

  def test_por_query
    porqry = Syspro::BusinessObjects::PorQry.new

    porqry.purchase_order = " 00001"
    porqry.include_stocked_lines = false
    porqry.include_non_stocked_lines = false
    porqry.include_freight_lines = false
    porqry.include_miscellaneous_lines = false
    porqry.include_comment_lines = false
    porqry.include_completed_lines = false
    porqry.include_grns = false
    porqry.include_history = false
    porqry.include_lct_details = false
    porqry.include_requisition_details = false
    porqry.include_requisition_routing = false
    porqry.include_sales_orders = false
    porqry.include_custom_forms = false
    porqry.filter_type = "A"
    porqry.filter_value = ""

    por_result = porqry.call(user_id.guid)
    assert_kind_of(Syspro::BusinessObjects::Models::PorDetail, por_result)
  end
end
