require "cgi"
require "faraday"
require "json"
require "logger"
require "openssl"

require "syspro/version"
require "syspro/syspro_client"

module Syspro
  # Your code goes here...
  #

  def self.ca_store
    @ca_store ||= begin
      store = OpenSSL::X509::Store.new
      store.add_file(ca_bundle_path)
      store
    end
  end
end
