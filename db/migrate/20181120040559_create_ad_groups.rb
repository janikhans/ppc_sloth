class CreateAdGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :ad_groups do |t|
      t.references :campaign, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
