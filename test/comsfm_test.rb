# frozen_string_literal: true

require 'test_helper'

class ComsFmTest < Minitest::Test
  extend Minitest::Spec::DSL

  let(:username) { 'wland' }
  let(:password) { 'Piperita2018' }
  let(:company) { 'L' }
  let(:company_password) { '' }
  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  def test_comsfm
    cust_item = Syspro::BusinessObjects::Models::ComsFmItem.new
    cust_item.form_type = "POR"
    cust_item.key_field = "U03421"
    cust_item.field_name = "TempPO"
    cust_item.alpha_value = "Y"

    cust_form = Syspro::BusinessObjects::ComsFm.new
    cust_form.validate_only = "Y"
    cust_form.items = [cust_item]

    errors = cust_form.call(user_id.guid)

    assert_equal errors.length, 0
  end
end