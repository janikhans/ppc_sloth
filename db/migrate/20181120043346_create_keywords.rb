class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.references :ad_group, foreign_key: true
      t.string :text, null: false
      t.integer :match_type
      t.boolean :auto, default: false
      t.integer :status
      t.integer :amazon_id, limit: 8, index: true

      t.timestamps
    end
  end
end
