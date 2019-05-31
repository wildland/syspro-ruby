# frozen_string_literal: true

require 'test_helper'

class PorTorTest < Minitest::Test
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

  def test_portor
    receipt_intero = Syspro::BusinessObjects::Models::ReceiptInterospection.new
    receipt_intero.purchase_order = 'Z01308'
    receipt_intero.warehouse = 'P0'
    receipt_intero.stock_code = '8801'
    receipt_intero.quantity = 0.01
    receipt_intero.delivery_note = 'DELIVER NOTE HERE-WL'
    receipt_intero.certificate = '8/45-3'
    receipt_intero.lot = '7097505'

    req = Syspro::BusinessObjects::PorTor.new
    req.transaction_date = Time.now.strftime('%Y-%m-%d')
    req.ignore_warnings = 'N'

    req.receipt_interospections = [receipt_intero]
    resp = req.call(user_id.guid)

    assert_equal resp[:error_numbers].length, 0
  end
end
