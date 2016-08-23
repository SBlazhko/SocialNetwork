class UserInfo < ApplicationRecord
  
  belongs_to :profile

  enum accsses: [:level_one, :level_two, :level_three]
  
end
