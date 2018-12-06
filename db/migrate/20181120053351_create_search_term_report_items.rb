class CreateSearchTermReportItems < ActiveRecord::Migration[5.2]
  def change
    create_table :search_term_report_items do |t|
      t.references :report, foreign_key: true
      t.references :ad_group, foreign_key: true
      t.references :keyword, foreign_key: true
      t.references :search_term, foreign_key: true
      t.date :date
      t.string :currency
      t.integer :impressions
      t.integer :clicks
      t.integer :click_through_rate
      t.integer :cost_per_click
      t.integer :spend
      t.integer :seven_days_total_sales
      t.integer :total_advertising_cost_of_sales
      t.integer :total_return_on_advertising_spend
      t.integer :seven_day_total_orders
      t.integer :seven_day_total_units
      t.integer :seven_day_conversion_rate
      t.integer :seven_day_advertised_sku_units
      t.integer :seven_day_other_sku_units
      t.integer :seven_day_advertised_sku_sales
      t.integer :seven_day_other_sku_sales

      t.timestamps
    end
  end
end
