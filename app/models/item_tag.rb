class ItemTag < ApplicationRecord
  belongs_to :item, inverse_of: :item_tags
  belongs_to :tag
end