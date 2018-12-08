class CreateAdGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :ad_groups do |t|
      t.references :campaign, foreign_key: true
      t.string :name
      t.integer :status, default: 0
      t.integer :amazon_id, limit: 8, index: true

      t.timestamps
    end
  end
end
