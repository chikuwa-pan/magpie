class Condition < ActiveHash::Base
  self.data = [
    { id: 1, name: '-' },
    { id: 2, name: '新品未開封' },
    { id: 3, name: '完品' },
    { id: 4, name: '美品' },
    { id: 5, name: '難有り' },
    { id: 6, name: 'ジャンク' },
  ]

  include ActiveHash::Associations
  has_many :items

  end