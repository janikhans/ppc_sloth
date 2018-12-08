class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :targeting_type, default: 0
      t.integer :status, default: 0
      t.integer :amazon_id, limit: 8, index: true

      t.timestamps
    end
  end
end
