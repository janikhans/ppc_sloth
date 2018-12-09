class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.references :sku, foreign_key: true
      t.references :ad_group, foreign_key: true
      t.integer :status
      t.integer :amazon_id, limit: 8, index: true

      t.timestamps
    end
  end
end
