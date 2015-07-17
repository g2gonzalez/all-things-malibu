class OrdersController < ApplicationController

  before_action :authorize, except: [ :show ]
  before_action :find_order, only: [ :show, :edit, :update, :destroy ]

  def sales
    @orders = Order.all.where( seller: current_user ).order( "created_at DESC" )
  end

  def purchases
    @orders = Order.all.where( buyer: current_user ).order( "created_at DESC" )
  end

  def new
    @order = Order.new
    @listing = Listing.find( params[ :listing_id ] )
  end

  def create
    @order = Order.new( order_params )
    @listing = Listing.find( params[ :listing_id ] )
    @seller = @listing.user

    @order.listing_id = @listing.id
    @order.seller_id = @seller.id
    @order.buyer_id = current_user.id

    Stripe.api_key = ENV[ "stripe_api_key" ]
    token = params[ :stripeToken ]
    puts "PARAMS STRIPE TOKEN: #{params[:stripeToken]}"

    begin
      charge = Stripe::Charge.create(
        :amount => ( @listing.price * 100 ).floor,
        :currency => "usd",
        :card => token
        )
      flash[ :success ] = "Thanks for ordering!"
    rescue Stripe::CardError => e
      flash[ :danger ] = e.message
    end

    transfer = Stripe::Transfer.create(
      :amount => (@listing.price * 95).floor,
      :currency => "usd",
      :recipient => @seller.recipient_token
    )

    if @order.save
      redirect_to root_path
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

# 4000 0000 0000 0077