require "drb_logger_server/version"
require 'drb/drb'
require 'logger'

module DrbLoggerServer
  def self.start port=9000, logfile
    #$SAFE = 1   # disable eval() and friends
    DRb.start_service("druby://0.0.0.0:#{port}", Logger.new(logfile))
    DRb.thread.join
  end
end
