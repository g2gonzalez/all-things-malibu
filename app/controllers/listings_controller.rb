class ListingsController < ApplicationController

  before_action :authorize, except: [ :show ]
  before_action :check_user, only: [ :edit, :update, :destroy ]
  before_action :find_listing, only: [ :show, :edit, :update, :destroy, :upvote ]

  def seller
    @listings = Listing.where( user: current_user ).order( "created_at DESC" )
  end

  def index
    # @listings = Listing.all.order( "created_at DESC" )
    @listings = Listing.where( user: current_user ).order( "created_at DESC" )
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

    def check_user
      listing = Listing.find( params[ :id ] )
      if current_user.id != listing.user.id
        redirect_to root_path, flash: { warning: "Sorry, this listing belongs to someone else" }
      end
    end

end