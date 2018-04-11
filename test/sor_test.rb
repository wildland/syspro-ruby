# frozen_string_literal: true

require 'test_helper'

class SorTest < Minitest::Test
  extend Minitest::Spec::DSL
  before { VCR.insert_cassette name }
  after { VCR.eject_cassette }

  let(:username) { 'wland' }
  let(:password) { 'piperita2016' }
  let(:company) { 'L' }
  let(:company_password) { '' }
  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  def test_sor_query
    sorqbs = Syspro::BusinessObjects::SorQbs.new

    sorqbs.include_sales_order_details = true
    sorqbs.include_contact_details = true
    sorqbs.include_delivery_history = true
    sorqbs.include_unconfirmed_releases = true
    sorqbs.include_confirmed_releases = true
    sorqbs.include_release_details = true
    sorqbs.include_release_history = true
    sorqbs.filters = [
      { name: 'Customer', type: 'A', value: 'JJJ001' }
    ]

    sor_result = sorqbs.call(user_id.guid)
    refute_nil sor_result
  end
end

