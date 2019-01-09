# frozen_string_literal: true

require 'test_helper'

class SorTest < Minitest::Test
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

  def test_sor_query
    sorqbs = Syspro::BusinessObjects::SorQry.new

    sorqbs.sales_order = '16R069'
    sorqbs.invoice = nil
    sorqbs.stocked_lines = true
    sorqbs.non_stocked_lines = true
    sorqbs.freight_lines = true
    sorqbs.misc_lines = true
    sorqbs.comment_lines = true
    sorqbs.completed_lines = true
    sorqbs.serials = true
    sorqbs.lots = true
    sorqbs.bins = true
    sorqbs.attached_items = true
    sorqbs.custom_forms = true
    sorqbs.detail_line_custom_forms = true
    sorqbs.values = true
    sorqbs.line_ship_date = true

    sor_result = sorqbs.call(user_id.guid)

    puts " "
    puts "================================================="
    puts "================================================="
    puts " "
    puts password
    puts " "
    puts "================================================="
    puts "================================================="
    puts " "

    assert_kind_of Syspro::BusinessObjects::Models::SorDetail, sor_result
  end
end
