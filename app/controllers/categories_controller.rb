class CategoriesController < ApplicationController

  before_action :authorize, except: [ :show ]
  before_action :find_listing, only: [ :edit, :update, :destroy ]

  def index
    @categories = Category.all.order( "created_at DESC" )
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new( category_params )

    if @category.save
      redirect_to categories_path, flash: { info: "New category created successfully" }
    else
      render :new
    end
  end

  def edit
    if @category.update( category_params )
      redirect_to categories_path, flash: { info: "Category successfully updated" }
    else
      render :edit
    end
  end

  def update
  end

  def destroy
    @category.destroy

    redirect_to root_path, flash: { info: "Category successfully deleted" }
  end

  private
    def find_category
      @category = Category.find( params[ :id ] )
    end

    def category_params
      params.require( :category ).permit( :name )
    end
end