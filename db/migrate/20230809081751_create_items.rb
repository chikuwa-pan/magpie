class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string     :name, null: false
      t.integer    :condition_id
      t.integer    :rarity_id
      t.string     :product
      t.date       :release
      t.string     :route
      t.string     :get_date
      t.text       :memo
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end