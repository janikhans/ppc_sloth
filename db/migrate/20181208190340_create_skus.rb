class CreateSkus < ActiveRecord::Migration[5.2]
  def change
    create_table :skus do |t|
      t.string :name
      t.string :asin
      t.integer :amazon_id, limit: 8, index: true

      t.timestamps
    end
  end
end
