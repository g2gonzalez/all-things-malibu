class Listing < ActiveRecord::Base

	mount_uploader :listing_img, ListingImgUploader
	validates_presence_of :listing_img
	validates :name, :description, :price, presence: true
  	validates :price, numericality: { greater_than: 0 }

  	belongs_to :user
  	has_many :orders

end
