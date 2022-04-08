class Item < ApplicationRecord
  belongs_to :user, inverse_of: :items

  with_options presence: true do
    validates :title
    validates :reactions_count
    validates :likes_count
  end
end