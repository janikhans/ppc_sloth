class DashboardsController < ApplicationController
  def show
    @aggregate_stats = TargetingReportItem.select('
      MIN(date) AS start_date,
      MAX(date) AS end_date,
      COALESCE(SUM(impressions), 0) AS impressions,
      COALESCE(SUM(clicks), 0) AS clicks,
      COALESCE(SUM(spend), 0) AS spend,
      COALESCE(SUM(seven_day_total_sales), 0) as sales
    ')[0]
  end
end
