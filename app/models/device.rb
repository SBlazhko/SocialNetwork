class Device < ApplicationRecord
  belongs_to :profile
  validates :token, uniqueness: true

  enum platform: [:android, :ios]

  def get_tokens(id_arr)
    tokens_arr = []
    id_arr.each do |profile_id|
      dev = Device.where(profile_id: profile_id, enabled: true)
      tokens_arr << dev.token
    end
    tokens_arr
  end
end
