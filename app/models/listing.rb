class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations, dependent: :destroy
	mount_uploaders :images, AvatarUploader

	def self.search(search)
	  where("name LIKE ? OR country LIKE ? OR city LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end
