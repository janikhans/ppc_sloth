class AdGroup < ApplicationRecord
  include Statusable

  belongs_to :campaign
  has_many :keywords
  has_many :ads
  has_many :skus, through: :ads
  has_many :targeting_report_items
  has_many :advertised_product_report_items
  has_many :search_term_report_items
  has_many :search_terms, through: :search_term_report_items


  scope :with_stats, lambda {
    select('ad_groups.*, aggregate_stats.*')
      .joins(
        <<~SQL
          LEFT JOIN (
            SELECT ad_group_id, SUM(impressions) AS impressions, SUM(clicks) AS clicks, SUM(spend) AS spend, SUM(seven_day_total_sales) AS sales
            FROM search_term_report_items
            GROUP BY ad_group_id
          ) AS aggregate_stats ON aggregate_stats.ad_group_id = ad_groups.id
        SQL
      )
  }
end
