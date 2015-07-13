class LandingsController < ApplicationController

  def index
    @listings = Listing.all.order( "created_at DESC" )
  end

  def about
  end

  def contact
  end

end