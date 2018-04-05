require "test_helper"

class QueryTest < Minitest::Test
  def test_query
    user_id = Syspro::Logon.logon("wland", "piperita2016", "L", "")

    combrw = Syspro::BusinessObjects::ComBrw.new
    combrw.browse_name = "InvMaster"
    combrw.start_condition = ""
    combrw.return_rows = 5
    combrw.filters = []
    combrw.table_name = "InvMaster"
    combrw.title = "StockCodes"
    combrw.columns = [
      {name: "StockCode"}
    ]

    query_result = combrw.call(user_id.guid)

    refute_nil query_result
  end
end
