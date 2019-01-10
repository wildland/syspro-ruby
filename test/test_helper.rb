# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'syspro'

require 'pry'
require 'minitest/autorun'
require 'minitest-vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<syspro_username>') { ENV['SYSPRO_USERNAME'] }
  c.filter_sensitive_data('<syspro_password>') { ENV['SYSPRO_PASSWORD'] }
  c.filter_sensitive_data('<syspro_company>') { ENV['SYSPRO_COMPANY'] }
end

MinitestVcr::Spec.configure!
