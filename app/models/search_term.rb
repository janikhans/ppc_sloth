class SearchTerm < ApplicationRecord
  scope :asin, -> { where(asin: true) }
  scope :customer_term, -> { where(asin: false) }

  has_many :search_term_report_items
  has_many :keywords,
    -> { positive.distinct },
    through: :search_term_report_items

  before_validation :check_if_asin

  scope :with_stats, lambda {
    select('
      search_terms.*,
      report_stats.*,
      CASE report_stats.impressions
        WHEN 0 THEN 0
        ELSE (report_stats.clicks::FLOAT / report_stats.impressions)
        END AS ctr,
      CASE report_stats.sales
        WHEN 0 THEN 0
        ELSE (report_stats.spend::FLOAT / report_stats.sales)
        END AS acos
      ')
      .joins('
        LEFT JOIN (
          SELECT search_term_id,
            SUM(impressions) AS impressions,
            SUM(clicks) AS clicks,
            SUM(spend) AS spend,
            SUM(seven_day_total_sales) AS sales,
            COUNT(*) AS reported_days
          FROM search_term_report_items
          GROUP BY search_term_id
        ) AS report_stats ON search_terms.id = report_stats.search_term_id
      ')
  }

  private

  def check_if_asin
    return unless text.present?
    self.asin = text.match?(/(b0)\w+/)
  end
end
