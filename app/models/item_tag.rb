class ItemTag
  include ActiveModel::Model
  attr_accessor :name, 
                :condition_id, 
                :rarity_id, 
                :product, 
                :release, 
                :route, 
                :get_date, 
                :memo, 
                :image, 
                :tag

  validates :name, presence: true

  def save
    Item.create(name: name, 
                condition_id: condition_id,
                rarity_id: rarity_id,
                product: product,
                release: release,
                route: route,
                get_date: get_date,
                memo: memo,
                image: image,
                tag: tag)
  end
end