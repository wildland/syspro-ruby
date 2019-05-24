# frozen_string_literal: true

require 'test_helper'

class ComsFmTest < Minitest::Test
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

  def test_comsfm
    cust_item = Syspro::BusinessObjects::Models::ComsFmItem.new
    cust_item.form_type = "POR"
    cust_item.key_field = "U03679"
    cust_item.field_name = "TempPO"
    cust_item.alpha_value = "Y"

    cust_form = Syspro::BusinessObjects::ComsFm.new
    cust_form.validate_only = "Y"
    cust_form.items = [cust_item]

    errors = cust_form.add(user_id.guid)

    assert_equal errors.length, 0
  end
end
