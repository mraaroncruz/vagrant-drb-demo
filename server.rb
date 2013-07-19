require "drb/drb"
require 'logger'

URI = "druby://0.0.0.0:3030"
DRb.start_service URI, Logger.new("./dev.log")
puts URI
DRb.thread.join
