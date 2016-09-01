class Device < ApplicationRecord
  belongs_to :profile
  validates :token, uniqueness: true
end
