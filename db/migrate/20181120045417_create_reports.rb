class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :type
      t.date :period_start
      t.date :period_end
      t.datetime :analyzed_at
      t.datetime :imported_at
      t.boolean :file_format_valid
      t.string :file_errors

      t.timestamps
    end
  end
end
