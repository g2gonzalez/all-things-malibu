class User < ActiveRecord::Base

   has_many :listings
   validates :username, :email, presence: true
   validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
   has_secure_password

end
