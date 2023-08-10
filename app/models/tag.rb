class Tag < ApplicationRecord
  has_many :taggings,dependent: :destroy, foreign_key: 'tag_id'
  has_many :items, through: :taggings
end