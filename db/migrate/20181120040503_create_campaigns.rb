class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.boolean :auto, default: false

      t.timestamps
    end
  end
end
