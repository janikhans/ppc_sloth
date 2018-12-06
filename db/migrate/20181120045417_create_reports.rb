class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :type
      t.date :period_start
      t.date :period_end
      t.datetime :analyzed_at
      t.datetime :imported_at

      t.timestamps
    end
  end
end
