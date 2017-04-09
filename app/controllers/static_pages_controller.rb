class StaticPagesController < ApplicationController
  def landing
  end

  def temperature_map
    @default_location = { latitude: APP_CONFIG["def_lat"], longitude: APP_CONFIG["def_lng"] }
  end
end
