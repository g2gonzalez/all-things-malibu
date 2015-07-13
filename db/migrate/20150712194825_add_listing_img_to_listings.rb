class AddListingImgToListings < ActiveRecord::Migration
  def change
    add_column :listings, :listing_img, :string
  end
end
