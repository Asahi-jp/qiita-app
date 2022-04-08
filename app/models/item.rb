class Item < ApplicationRecord
  belongs_to :user, inverse_of: :items
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags

  with_options presence: true do
    validates :title
    validates :reactions_count
    validates :likes_count
  end
end