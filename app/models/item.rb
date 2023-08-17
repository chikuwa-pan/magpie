class Item < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings, dependent: :destroy

  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :condition, class_name: 'Condition'
    belongs_to :rarity, class_name: 'Rarity'

  def self.search(search)
    if search.present?
      Item.joins(:tags).where(
        'items.name LIKE :search OR items.memo LIKE :search OR items.product LIKE :search OR tags.tag_name LIKE :search',
        search: "%#{search}%"
      ).distinct
    else
      Item.none
    end
  end
end