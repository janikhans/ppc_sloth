class SearchTermReportItem < ApplicationRecord
  belongs_to :ad_group
  belongs_to :keyword
  belongs_to :search_term
  belongs_to :report
end
