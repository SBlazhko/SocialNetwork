class Post < ApplicationRecord

	belongs_to :profile
	
	enum access_level: [:level_one, :level_two, :level_three]

	def post_show_params
		{
			id: id,
			profile_id: profile_id,
			access_level: access_level,
			text: text,
			created_at: created_at
		}
	end
end
