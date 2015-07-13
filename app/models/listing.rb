class Listing < ActiveRecord::Base

	mount_uploader :listing_img, ListingImgUploader
	belongs_to :user

end
