class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.references :ad_group, foreign_key: true
      t.string :text, null: false
      t.integer :match_type, default: 0
      t.boolean :auto, default: false

      t.timestamps
    end
  end
end
