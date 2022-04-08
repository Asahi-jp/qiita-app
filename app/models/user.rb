class User < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :profile_image_url, presence: true
end
