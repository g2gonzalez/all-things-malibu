class Listing < ActiveRecord::Base

	mount_uploader :listing_img, ListingImgUploader
	belongs_to :user
	validates_presence_of :listing_img
	validates :name, :description, :price, :quantity, presence: true
  	validates :price, :quantity, numericality: { greater_than: 0 }

end
