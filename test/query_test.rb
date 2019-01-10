# frozen_string_literal: true

require 'test_helper'

class QueryTest < Minitest::Test
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

  def test_query_browse # rubocop:disable Metrics/MethodLength
    skip 'A new VCR cassette needs recorded for this test to pass'
    combrw = Syspro::BusinessObjects::ComBrw.new
    combrw.browse_name = 'InvMaster'
    combrw.start_condition = ''
    combrw.return_rows = 5
    combrw.filters = []
    combrw.table_name = 'InvMaster'
    combrw.title = 'StockCodes'
    combrw.columns = [
      { name: 'StockCode' }
    ]

    browse_result = combrw.call(user_id.guid)

    refute_nil browse_result
  end

  def test_query_query # rubocop:disable Metrics/MethodLength
    comfnd = Syspro::BusinessObjects::ComFnd.new
    comfnd.table_name = 'InvMaster'
    comfnd.return_rows = 5
    comfnd.columns = [
      {
        name: 'StockCode'
      }
    ]
    comfnd.expressions = [
      {
        andor: 'And',
        column: 'StockCode',
        condition: 'EQ',
        value: '02'
      }
    ]
    comfnd.order_by = 'StockCode'

    query_result = comfnd.call(user_id.guid)

    refute_nil query_result
  end

  def test_query_fetch
    comfch = Syspro::BusinessObjects::ComFch.new
    comfch.table_name = 'InvMaster'
    comfch.key = '02'
    comfch.optional_keys = []
    comfch.full_key_provided = false
    comfch.default_type = ''
    comfch.espresso_fetch = true

    fetch_result = comfch.call(user_id.guid)

    refute_nil fetch_result
  end
end
