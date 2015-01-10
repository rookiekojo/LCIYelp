class Church < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
