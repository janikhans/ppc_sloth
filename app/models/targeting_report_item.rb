class TargetingReportItem < ApplicationRecord
  belongs_to :ad_group
  belongs_to :keyword
  belongs_to :report
end
