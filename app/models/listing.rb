class Listing < ApplicationRecord
	belongs_to :user

	mount_uploaders :images, AvatarUploader

	def self.search(search)
	  where("name LIKE ? OR country LIKE ? OR city LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end
