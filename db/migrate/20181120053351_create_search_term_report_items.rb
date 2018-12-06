class CreateSearchTermReportItems < ActiveRecord::Migration[5.2]
  def change
    create_table :search_term_report_items do |t|
      t.references :report, foreign_key: true
      t.references :ad_group, foreign_key: true
      t.references :keyword, foreign_key: true
      t.references :search_term, foreign_key: true
      t.date :date
      t.string :currency
      t.integer :impressions, default: 0
      t.integer :clicks, default: 0
      t.decimal :click_through_rate, precision: 9, scale: 4, default: 0
      t.integer :cost_per_click, default: 0
      t.integer :spend, default: 0
      t.integer :seven_day_total_sales, default: 0
      t.integer :total_advertising_cost_of_sales, default: 0
      t.decimal :total_return_on_advertising_spend, precision: 9, scale: 4, default: 0
      t.integer :seven_day_total_orders, default: 0
      t.integer :seven_day_total_units, default: 0
      t.decimal :seven_day_conversion_rate, precision: 9, scale: 4, default: 0
      t.integer :seven_day_advertised_sku_units, default: 0
      t.integer :seven_day_other_sku_units, default: 0
      t.integer :seven_day_advertised_sku_sales, default: 0
      t.integer :seven_day_other_sku_sales, default: 0

      t.timestamps
    end
  end
end
