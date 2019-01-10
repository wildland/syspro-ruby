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
  c.allow_http_connections_when_no_cassette = true
  # TODO: change passwords and move them to ENV
  # c.filter_sensitive_data() { ENV[] }
end

MinitestVcr::Spec.configure!
