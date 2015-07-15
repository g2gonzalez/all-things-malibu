class OrdersController < ApplicationController

  before_action :authorize, except: [ :show ]
  before_action :find_order, only: [ :show, :edit, :update, :destroy ]

  def show
  end

  def new
    @order = Order.new
    @listing = Listing.find( params[ :listing_id ] )
  end

  def create
    @order = Order.new( order_params )
    @listing = Listing.find( params[ :listing_id ] )
    @order.listing_id = params[ :listing_id ]
    @order.seller_id = @listing.user.id
    @order.buyer_id = current_user.id

    if @order.save
      redirect_to root_path, flash: { success: "Your order was successfully placed" }
    else
      render :new
    end
  end

  private
    def find_listing
      @order = Order.find( params[ :id ] )
    end

    def order_params
      params.require( :order ).permit( :address, :city, :state )
    end

end