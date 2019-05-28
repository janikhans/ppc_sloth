class StatsController < ApplicationController
  def impressions
    render json: TargetingReportItem.group_by_day(:date).sum(:impressions)
  end

  def clicks
    render json: TargetingReportItem.group_by_day(:date).sum(:clicks)
  end

  def spend
    render json: TargetingReportItem.group_by_day(:date).sum('spend / 100.0')
  end

  def sales
    render json: TargetingReportItem.group_by_day(:date).sum('seven_day_total_sales / 100.0')
  end
end
