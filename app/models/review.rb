class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :church
end
