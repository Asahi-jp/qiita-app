class User < ApplicationRecord

  validates :profile_image_url, presence: true
end
