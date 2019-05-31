require 'test_helper'

class PorTest < Minitest::Test
  extend Minitest::Spec::DSL

  before { VCR.insert_cassette name }
  after { VCR.eject_cassette }

  let(:username) { ENV['SYSPRO_USERNAME'] }
  let(:password) { ENV['SYSPRO_PASSWORD'] }
  let(:company) { ENV['SYSPRO_COMPANY'] }
  let(:company_password) { '' }

  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  def test_por_query
    porqry = Syspro::BusinessObjects::PorQry.new

    porqry.purchase_order = ' 00001'
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
    porqry.filter_type = 'A'
    porqry.filter_value = ''

    por_result = porqry.call(user_id.guid)
    assert_kind_of(Syspro::BusinessObjects::Models::PorDetail, por_result)
  end
end
