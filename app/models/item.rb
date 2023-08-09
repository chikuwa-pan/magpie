class Item < ApplicationRecord
  validates :name, presence: true
  has_one_attached :image
end
