class Sku < ApplicationRecord
  has_many :ads
  has_many :ad_groups, through: :ads
  has_many :keywords, through: :ad_groups
  has_many :campaigns, through: :ad_groups
  has_many :advertised_product_report_items

  has_many :search_terms,
    -> { distinct },
    through: :ad_groups

  has_many :customer_search_terms,
    -> { customer_term.distinct },
    through: :ad_groups,
    source: :search_terms

  has_many :related_asins,
    -> { asin.distinct },
    through: :ad_groups,
    source: :search_terms
end
