# Model User Info
class UserInfo < ApplicationRecord
  belongs_to :profile

  enum access_level: [:level_one, :level_two, :level_three]
end
