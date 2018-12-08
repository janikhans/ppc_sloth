class CreateBulksheets < ActiveRecord::Migration[5.2]
  def change
    create_table :bulksheets do |t|
      t.boolean :file_format_valid
      t.datetime :analyzed_at
      t.datetime :imported_at

      t.timestamps
    end
  end
end
