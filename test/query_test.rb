# frozen_string_literal: true

require 'test_helper'

class QueryTest < Minitest::Test
  def test_query_browse # rubocop:disable Metrics/MethodLength
    user_id = Syspro::Logon.logon('wland', 'piperita2016', 'L', '')

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
    user_id = Syspro::Logon.logon('wland', 'piperita2016', 'L', '')

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
    user_id = Syspro::Logon.logon('wland', 'piperita2016', 'L', '')

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
