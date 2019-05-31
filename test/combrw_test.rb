# frozen_string_literal: true

require 'test_helper'

class ComBrwTest < Minitest::Test
  extend Minitest::Spec::DSL
  before do
    VCR.insert_cassette name
  end
  after { VCR.eject_cassette }

  let(:username) { ENV['SYSPRO_USERNAME'] }
  let(:password) { ENV['SYSPRO_PASSWORD'] }
  let(:company) { ENV['SYSPRO_COMPANY'] }
  let(:company_password) { '' }
  let(:user_id) do
    Syspro::Logon.logon(username, password, company, company_password)
  end

  def test_inv_wh_ctrl_qry
    com_browse = Syspro::BusinessObjects::ComBrw.new

    com_browse.return_rows = 30
    com_browse.browse_name = 'LabbeeInvWhControl'
    query = com_browse.call(user_id.guid)

    assert_kind_of Syspro::BusinessObjects::Parsers::ComBrwParser::BrowseObject, query
    assert query.headers, 'has headers'
    assert_equal 2, query.headers.count, 'has headers'
    assert query.prev_key, 'has a previous key'
    assert query.next_key, 'has a next key'
    assert query.key, 'has a key'
    assert_includes [true, false], query.fwd
    assert_includes [true, false], query.back
    query.rows.each do |row|
      assert_kind_of(
        Hash,
        row
      )

      assert row.key?('Warehouse'), 'row should contain a warehouse'
      assert row.key?('Description'), 'row should contain a description'
    end
  end
end
