class Campaign < ApplicationRecord
  include Statusable

  has_many :ad_groups
  has_many :skus,
    -> { distinct },
    through: :ad_groups
  has_many :search_term_report_items, through: :ad_groups
  has_many :targeting_report_items, through: :ad_groups
  has_many :keywords, through: :ad_groups

  has_many :search_terms, through: :search_term_report_items

  enum targeting_type: {
    auto: 0,
    manual: 1
  }

  def aggregate_stats
    targeting_report_items.select('
      COALESCE(SUM(impressions), 0) AS impressions,
      COALESCE(SUM(clicks), 0) AS clicks,
      COALESCE(SUM(spend), 0) AS spend,
      COALESCE(SUM(seven_day_total_sales), 0) as sales
    ')[0]
  end

  scope :with_stats, lambda {
    select('campaigns.*,
      COALESCE(SUM(stats.impressions), 0) AS impressions,
      COALESCE(SUM(stats.clicks), 0) AS clicks,
      COALESCE(SUM(stats.spend), 0) AS spend,
      COALESCE(SUM(stats.sales), 0) AS sales')
      .joins(
        <<~SQL
          LEFT JOIN ad_groups ON ad_groups.campaign_id = campaigns.id
          LEFT JOIN (
            SELECT ad_group_id, impressions, clicks, spend, seven_day_total_sales AS sales
            FROM targeting_report_items
          ) AS stats ON stats.ad_group_id = ad_groups.id
          GROUP BY campaigns.id
        SQL
      )
  }
  #
  # def aggregate_stats
  #   search_term_report_items.select('
  #     COALESCE(SUM(impressions), 0) AS impressions,
  #     COALESCE(SUM(clicks), 0) AS clicks,
  #     COALESCE(SUM(spend), 0) AS spend,
  #     COALESCE(SUM(seven_day_total_sales), 0) as sales
  #   ')[0]
  # end
  #
  # scope :with_stats, lambda {
  #   select('campaigns.*,
  #     COALESCE(SUM(stats.impressions), 0) AS impressions,
  #     COALESCE(SUM(stats.clicks), 0) AS clicks,
  #     COALESCE(SUM(stats.spend), 0) AS spend,
  #     COALESCE(SUM(stats.sales), 0) AS sales')
  #     .joins(
  #       <<~SQL
  #         LEFT JOIN ad_groups ON ad_groups.campaign_id = campaigns.id
  #         LEFT JOIN (
  #           SELECT ad_group_id, impressions, clicks, spend, seven_day_total_sales AS sales
  #           FROM search_term_report_items
  #         ) AS stats ON stats.ad_group_id = ad_groups.id
  #         GROUP BY campaigns.id
  #       SQL
  #     )
  # }
end
