class CreateSearchTermReports < ActiveRecord::Migration[5.2]
  def change
    create_table :search_term_reports do |t|
      t.string :name
      t.boolean :processed, default: false

      t.timestamps
    end
  end
end
