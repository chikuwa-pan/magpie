class Item < ApplicationRecord


  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :condition, class_name: 'Condition'
    belongs_to :rarity, class_name: 'Rarity'
end
