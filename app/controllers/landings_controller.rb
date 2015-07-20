class LandingsController < ApplicationController

  def index
    if params[ :category ].blank?
      @listings = Listing.all.order( "created_at DESC" )
    else
      @category_id = Category.find_by( name: params[ :category ] ).id
      @listings = Listing.where( category_id: @category_id ).order( "created_at DESC" )
    end
  end

  def about
  end

  def contact
  end

end