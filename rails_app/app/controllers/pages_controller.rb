class PagesController < ApplicationController
  def home
    logger.info `ifconfig | grep 33.33.33`
    logger.info "OHAI"
  end
end
