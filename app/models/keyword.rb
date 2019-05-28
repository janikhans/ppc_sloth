class Keyword < ApplicationRecord
  include Statusable

  NEGATIVE_MATCH_TYPES = [:negative_exact, :negative_phrase].freeze
  POSITIVE_MATCH_TYPES = [:broad, :phrase, :exact].freeze

  scope :auto, -> { where(auto: true) }
  scope :negative, -> { where(match_type: NEGATIVE_MATCH_TYPES) }
  scope :positive, -> { where(match_type: POSITIVE_MATCH_TYPES) }

  scope :with_stats, lambda {
    select('
      keywords.*,
      report_stats.*,
      CASE report_stats.impressions
        WHEN 0 THEN 0
        ELSE (report_stats.clicks::FLOAT / report_stats.impressions)
        END AS ctr,
      CASE report_stats.sales
        WHEN 0 THEN 0
        ELSE (report_stats.spend::FLOAT / report_stats.sales)
        END AS acos,
      CASE report_stats.spend
        WHEN 0 THEN 0
        ELSE ((report_stats.sales::FLOAT - report_stats.spend::FLOAT) / report_stats.spend)
        END AS roi
      ')
      .joins('
        LEFT JOIN (
          SELECT keyword_id, SUM(impressions) AS impressions, SUM(clicks) AS clicks, SUM(spend) AS spend, SUM(seven_day_total_sales) AS sales, COUNT(*) AS reported_days
          FROM targeting_report_items
          GROUP BY keyword_id
        ) AS report_stats ON keywords.id = report_stats.keyword_id
      ')
  }

  belongs_to :ad_group

  has_many :skus, through: :ad_group

  has_many :search_term_report_items
  has_many :targeting_report_items

  has_many :search_terms,
    -> { distinct },
    through: :search_term_report_items

  delegate :campaign, to: :ad_group

  enum match_type: {
    broad: 0,
    phrase: 1,
    exact: 2,
    negative_phrase: 3,
    negative_exact: 4,
    dash: 5
  }

  before_validation :check_if_auto

  def negative?
    NEGATIVE_MATCH_TYPES.include?(match_type)
  end

  def aggregate_stats
    targeting_report_items.select('
      COALESCE(SUM(impressions), 0) AS impressions,
      COALESCE(SUM(clicks), 0) AS clicks,
      COALESCE(SUM(spend), 0) AS spend,
      COALESCE(SUM(seven_day_total_sales), 0) AS sales,
      MIN(date) AS first_recorded,
      MAX(date) AS last_recorded
    ')[0]
  end

  private

  def check_if_auto
    return unless text.present?
    self.auto = text == '*'
  end
end
