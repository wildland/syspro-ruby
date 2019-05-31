# frozen_string_literal: true

require 'test_helper'

class PorTiiTest < Minitest::Test
  extend Minitest::Spec::DSL

  let(:username) { ENV['SYSPRO_USERNAME'] }
  let(:password) { ENV['SYSPRO_PASSWORD'] }
  let(:company) { ENV['SYSPRO_COMPANY'] }
  let(:company_password) { '' }
  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  def test_portii
    req = Syspro::BusinessObjects::PorTii.new

    req.item_inspected = Syspro::BusinessObjects::Models::InventoryInspection.new
    req.item_inspected.grn_number = 'P00012509'
    req.item_inspected.quantity = 12.312
    req.item_inspected.inspection_completed = 'Y'

    resp = req.call(user_id.guid)

    assert_equal resp.key?(:grn_numbers), true
    assert_equal resp.key?(:items_processed), true
    assert_equal resp.key?(:items_invalid), true
  end
end
