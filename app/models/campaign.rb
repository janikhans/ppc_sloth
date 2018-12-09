class Campaign < ApplicationRecord
  include Statusable

  has_many :ad_groups
  has_many :search_term_report_items, through: :ad_groups
  has_many :keywords, through: :ad_groups

  has_many :search_terms, through: :search_term_report_items

  enum targeting_type: {
    auto: 0,
    manual: 1
  }
end
