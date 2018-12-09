class Sku < ApplicationRecord
  has_many :ads
  has_many :ad_groups, through: :ads
  has_many :advertised_product_report_items
end
