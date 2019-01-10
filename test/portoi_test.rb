# frozen_string_literal: true

require 'test_helper'

class PorToiTest < Minitest::Test
  extend Minitest::Spec::DSL

  let(:username) { 'wland' }
  let(:password) { 'Piperita2018' }
  let(:company) { 'L' }
  let(:company_password) { '' }
  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  def test_portoi
    new_po = Syspro::BusinessObjects::PorToi.new
    new_po.purchase_order_header = Syspro::BusinessObjects::Models::PurchaseOrderHeader.new

    # Setup the PORTOI params
    new_po.validate_only = "N"
    new_po.ignore_warnings = "N"
    new_po.allow_non_stock_items = "N"
    new_po.allow_zero_price = "Y"
    new_po.validate_working_days = "N"
    new_po.allow_po_when_blanket_po = "N"
    new_po.default_memo_code = ""
    new_po.fixed_exchange_rate = "N"
    new_po.default_memo_days = 0
    new_po.allow_blank_ledger_code = "Y"
    new_po.default_delivery_address = ""
    new_po.calc_due_date = "N"
    new_po.insert_dangerous_goods_text = "N"
    new_po.insert_additional_po_text = "N"
    new_po.status = "1"

    # Setup the purchase order header data attributes
    new_po.purchase_order_header.order_action_type = "A"
    new_po.purchase_order_header.order_type = "L"
    new_po.purchase_order_header.supplier = "WYC001"
    new_po.purchase_order_header.customer_po_number = "H01993-1"
    new_po.purchase_order_header.buyer = "PCD"
    new_po.purchase_order_header.warehouse = "H0"
    new_po.purchase_order_header.tax_status = "N"
    new_po.purchase_order_header.invoice_terms = "X"
    new_po.purchase_order_header.order_date = Time.now.strftime("%Y-%m-%d")
    new_po.purchase_order_header.apply_due_date_to_lines = "A"
    new_po.purchase_order_header.disc_percent1 = 0
    new_po.purchase_order_header.disc_percent2 = 0
    new_po.purchase_order_header.disc_percent3 = 0
   
    po = new_po.call(user_id.guid)

    binding.pry

    assert_equal 1, 1
  end
end