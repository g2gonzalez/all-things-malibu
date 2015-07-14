class ListingsController < ApplicationController

  # check that the current user can only see the correct pages
  before_action :authorize, except: [ :display, :show ]
  before_action :find_listing, only: [ :show, :edit, :update, :destroy, :upvote ]

  def index
    @listings = Listing.all.order( "created_at DESC" )
  end

  def show
  end

  def new
    @listing = Listing.new
  end

  def edit
  end

  def create
    @listing = Listing.new( listing_params )
    @listing.user_id = current_user.id

    if @listing.save
      redirect_to @listing, flash: { info: "New listing created successfully" }
    else
      render :new
    end
  end

  def update
    if @listing.update( listing_params )
      redirect_to @listing, flash: { info: "LIsting successfully updated" }
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy

    redirect_to root_path, flash: { info: "Listing successfully deleted" }
  end

  private
    def find_listing
      @listing = Listing.find( params[ :id ] )
    end

    def listing_params
      params.require( :listing ).permit( :name, :description, :price, :quantity, :listing_img )
    end

end