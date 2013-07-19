require 'drb/drb' # require druby from the standard library

# This is necessary when you do wild stuff but let's just make
# a habit of it here
DRb.start_service

# Create an instance of the object instance that you created 
# from server.rb
logger = DRbObject.new("druby://33.33.33.100:3030")

# Treat it like a normal logger and see that it logs to the
# file you set up on your server
logger.info "Hello world"
