class CreateSearchTermReports < ActiveRecord::Migration[5.2]
  def change
    create_table :search_term_reports do |t|
      t.string :name
      t.datetime :imported

      t.timestamps
    end
  end
end
