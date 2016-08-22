class Token < ApplicationRecord
	tokenizable
	
	belongs_to :profile
	
end
