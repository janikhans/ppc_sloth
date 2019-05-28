class SearchTermIdentifier
  include ActiveModel::Model

  attr_accessor :sku_ids, :ad_group_ids, :target_acos, :target_impressions, :target_sales,
                :target_clicks, :limit, :order_column, :order_direction, :target_spend

  def initialize(params = {})
    params ||= {}
    params[:sku_ids] = params[:sku_ids]&.reject(&:blank?)

    @continue = params[:sku_ids].present?

    if @continue
      self.sku_ids          = Array.wrap(params[:sku_ids]).uniq
      self.ad_group_ids     = AdGroup.joins(:skus).where(skus: { id: @sku_ids }).pluck(:id).uniq
    end

    self.target_acos        = params[:target_acos]        || 0.15
    self.target_impressions = params[:target_impressions] || 0
    self.target_sales       = params[:target_sales]       || 0
    self.target_clicks      = params[:target_clicks]      || 10
    self.target_spend       = params[:target_spend]       || 0
    self.order_column       = params[:order_column]       || :sales
    self.order_direction    = params[:order_direction]    || :desc
    self.limit              = params[:limit]
  end

  def search_terms
    @search_terms ||= @continue ? find_search_terms : []
  end

  private

  def find_search_terms
    SearchTerm.from("(
      WITH
        setup AS (
          SELECT
            search_terms.*,
            report_stats.*
          FROM search_terms
          INNER JOIN (
            SELECT search_term_id,
              SUM(impressions) AS impressions,
              SUM(clicks) AS clicks,
              SUM(spend) AS spend,
              SUM(seven_day_total_sales) AS sales,
              COUNT(*) AS reported_days
            FROM search_term_report_items
            WHERE ad_group_id IN (#{ad_group_ids.join(',')})
            GROUP BY search_term_id
          ) AS report_stats ON report_stats.search_term_id = search_terms.id
        ),
        stats AS (
          SELECT
            setup.*,
            CASE setup.impressions
              WHEN 0 THEN 0
              ELSE (setup.clicks::FLOAT / setup.impressions)
              END AS ctr,
            CASE setup.sales
              WHEN 0 THEN NULL
              ELSE (setup.spend::FLOAT / setup.sales)
              END AS acos
          FROM setup
        ),
        targets AS (
          SELECT
            stats.*,
            stats.acos <= #{target_acos} AS target_acos_met,
            stats.impressions >= #{target_impressions} AS target_impressions_met,
            stats.sales >= #{target_sales} AS target_sales_met,
            stats.clicks >= #{target_clicks} AS target_clicks_met,
            stats.spend >= #{target_spend} * 100 AS target_spend_met
          FROM stats
        )
        SELECT
          targets.*,
          CASE
            WHEN NOT targets.target_clicks_met THEN 'more clicks needed'
            WHEN targets.target_acos_met THEN 'positive exact'
            WHEN targets.acos IS NULL AND targets.target_spend_met THEN 'negative exact'
            WHEN targets.acos IS NULL AND NOT targets.target_spend_met THEN 'wait'
            WHEN NOT targets.target_acos_met THEN 'negative exact'
            END AS recommendation
          FROM targets
    ) as search_terms ")
      .limit(limit)
      .order(order)
      .where(asin: false)
  end

  def order
    "#{order_column} #{order_direction} NULLS LAST, spend desc"
  end
end
