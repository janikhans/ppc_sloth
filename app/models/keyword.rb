class Keyword < ApplicationRecord
  include Statusable

  scope :auto, -> { where(auto: true) }

  scope :with_stats, lambda {
    select('keywords.*, report_stats.*, CASE report_stats.impressions WHEN 0 THEN 0 ELSE (report_stats.clicks::FLOAT / report_stats.impressions) END AS ctr')
      .joins(
        <<~SQL
          LEFT JOIN (
            SELECT keyword_id, SUM(impressions) AS impressions, SUM(clicks) AS clicks, COUNT(*) AS reported_days
            FROM search_term_report_items
            GROUP BY keyword_id
          ) AS report_stats ON keywords.id = report_stats.keyword_id
        SQL
      )
  }

  belongs_to :ad_group
  before_validation :check_if_auto

  has_many :search_term_report_items

  delegate :campaign, to: :ad_group

  enum match_type: {
    broad: 0,
    phrase: 1,
    exact: 2,
    negative_phrase: 3,
    negative_exact: 4
  }

  private

  def check_if_auto
    return unless text.present?
    self.auto = text == '*'
  end
end
