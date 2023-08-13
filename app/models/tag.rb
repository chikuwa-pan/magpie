class Tag < ApplicationRecord
  has_many :taggings, foreign_key: 'tag_id', dependent: :destroy
  has_many :items, through: :taggings

  before_destroy :destroy_orphaned_tag

  private

  def destroy_orphaned_tag
    puts "destroy_orphaned_tag method called"
    if items.empty?
      destroy
    end
  end
end