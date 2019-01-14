# frozen_string_literal: true

require 'test_helper'

class PorToiTest < Minitest::Test
  extend Minitest::Spec::DSL

  let(:username) { ENV['SYSPRO_USERNAME'] }
  let(:password) { ENV['SYSPRO_PASSWORD'] }
  let(:company) { ENV['SYSPRO_COMPANY'] }
  let(:company_password) { '' }
  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  def test_portoi
    po = Syspro::BusinessObjects::PorToi.new
    po.purchase_order_header = Syspro::BusinessObjects::Models::PurchaseOrders::Header.new

    # Setup the PORTOI params
    po.validate_only = "N"
    po.ignore_warnings = "N"
    po.allow_non_stock_items = "N"
    po.allow_zero_price = "Y"
    po.validate_working_days = "N"
    po.allow_po_when_blanket_po = "N"
    po.default_memo_code = ""
    po.fixed_exchange_rate = "N"
    po.default_memo_days = 0
    po.allow_blank_ledger_code = "Y"
    po.default_delivery_address = ""
    po.calc_due_date = "N"
    po.insert_dangerous_goods_text = "N"
    po.insert_additional_po_text = "N"
    po.status = "1"

    # Setup the purchase order header data attributes
    po.purchase_order_header.order_action_type = "A"
    po.purchase_order_header.order_type = "L"
    po.purchase_order_header.supplier = "WYC001"
    po.purchase_order_header.customer_po_number = "H01993-1"
    po.purchase_order_header.buyer = "PCD"
    po.purchase_order_header.warehouse = "P0"
    po.purchase_order_header.tax_status = "N"
    po.purchase_order_header.invoice_terms = "X"
    po.purchase_order_header.order_date = Time.now.strftime("%Y-%m-%d")
    po.purchase_order_header.apply_due_date_to_lines = "A"
    po.purchase_order_header.disc_percent1 = 0
    po.purchase_order_header.disc_percent2 = 0
    po.purchase_order_header.disc_percent3 = 0

    line1 = Syspro::BusinessObjects::Models::PurchaseOrders::StockLine.new
    line1.purchase_order_line = 1
    line1.line_action_type = "A"
    line1.stock_code = "8801"
    line1.warehouse = "P0"
    line1.order_qty = "100"
    line1.order_uom = "KG"
    line1.pieces = "0"
    line1.price_method = "M"
    line1.price = 0
    line1.line_disc_type = "P"
    line1.line_disc_less_plus = "L"
    line1.line_disc_percent1 = 0
    line1.line_disc_percent2 = 0
    line1.line_disc_percent3 = 0
    line1.line_disc_value = 0
    line1.taxable = "N"

    po.order_details = Syspro::BusinessObjects::Models::PurchaseOrders::OrderDetails.new
    po.order_details.stock_lines = [line1]

    syspro_po = po.call(user_id.guid)

    assert_equal syspro_po.error_numbers.length, 0
  end
end
