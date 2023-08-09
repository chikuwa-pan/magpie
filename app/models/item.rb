class Item < ApplicationRecord
  validates :name, presence: true

  has_one_attached :image
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :condition, class_name: 'Condition'
    belongs_to :rarity, class_name: 'Rarity'
end
