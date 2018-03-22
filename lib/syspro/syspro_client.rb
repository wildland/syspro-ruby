module Syspro
  class SysproClient
    def initialize(conn = nil)
      self.conn = conn || self.class.default_conn
      @system_profiler = SystemProfiler.new
    end

    def self.active_client
      Thread.current[:syspro_client] || default_client
    end

    def self.default_client
      Thread.current[:syspro_client_default_client] ||= SysproClient.new(default_conn)
    end

    def get_syspro_version

    end
  end
end

