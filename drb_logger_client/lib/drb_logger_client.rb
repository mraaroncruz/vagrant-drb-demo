require "drb_logger_client/version"
require 'drb/drb'

module DrbLoggerClient
  def initialize host, port
    server_uri = "druby://#{host}:#{port}"
    DRb.start_service
    @logger = DRbObject.new_with_uri(server_uri)
  end

  %w(debug info warn error fatal).each do |level|
    define_method level do |message|
      @logger.send level, message
    end
  end
end
