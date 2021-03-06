# frozen_string_literal: true

require 'test_helper'

class InvSwsTest < Minitest::Test
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

  def test_invsws
    skip 'A new VCR cassette needs recorded for this test to pass'
    invsws_item = Syspro::BusinessObjects::Models::InvSwsItem.new
    invsws_item.key_stock_code = '1004'
    invsws_item.key_warehouse = 'P0'
    invsws_item.default_bin = 'P0'

    invsws_req = Syspro::BusinessObjects::InvSws.new
    invsws_req.validate_only = 'Y'
    invsws_req.apply_product_class_default = 'BA'
    invsws_req.ignore_warnings = 'N'
    invsws_req.apply_if_entire_document_valid = 'Y'
    invsws_req.item = invsws_item

    invsws_resp = invsws_req.add(user_id.guid)

    assert_equal invsws_resp[:error_numbers].length, 0
  end

  def test_invsws_errors
    invsws_item = Syspro::BusinessObjects::Models::InvSwsItem.new
    invsws_item.key_stock_code = '1004'
    invsws_item.key_warehouse = 'P0'
    invsws_item.default_bin = 'P0'

    invsws_req = Syspro::BusinessObjects::InvSws.new
    invsws_req.validate_only = 'Y'
    invsws_req.apply_product_class_default = 'BA'
    invsws_req.ignore_warnings = 'N'
    invsws_req.apply_if_entire_document_valid = 'Y'
    invsws_req.item = invsws_item

    invsws_resp = invsws_req.add(user_id.guid)

    assert_equal invsws_resp[:errors].length, 1
  end
end
