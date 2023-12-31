class ItemTag
  include ActiveModel::Model
  include ActiveModel::Attributes
  attr_accessor :name, 
                :condition_id, 
                :rarity_id, 
                :product, 
                :release, 
                :route, 
                :get_date, 
                :memo, 
                :images,
                :tag_name


  validates :name, presence: true

  def save
    tag_names = tag_name.split(',').map(&:strip)

    item = Item.create(
      name: name,
      condition_id: condition_id,
      rarity_id: rarity_id,
      product: product,
      release: release,
      route: route,
      get_date: get_date,
      memo: memo
    )

    tag_names.each do |tag_name|
      tag = Tag.where(tag_name: tag_name).first_or_initialize
      tag.save if tag.new_record?
      Tagging.create(item: item, tag: tag)
    end
  end
end
