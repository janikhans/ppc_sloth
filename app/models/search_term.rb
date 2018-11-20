class SearchTerm < ApplicationRecord
  has_many :search_term_report_items

  scope :with_stats, lambda {
    select('search_terms.*, report_stats.*, CASE report_stats.impressions WHEN 0 THEN 0 ELSE (report_stats.clicks::FLOAT / report_stats.impressions) END AS ctr')
      .joins(
        <<~SQL
          LEFT JOIN (
            SELECT search_term_id, SUM(impressions) AS impressions, SUM(clicks) AS clicks, COUNT(*) AS reported_days
            FROM search_term_report_items
            GROUP BY search_term_id
          ) AS report_stats ON search_terms.id = report_stats.search_term_id
        SQL
      )
  }
end
