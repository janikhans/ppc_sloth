class AdGroup < ApplicationRecord
  include Statusable

  belongs_to :campaign
  has_many :keywords
  has_many :ads
  has_many :skus, through: :ads
  has_many :advertised_product_report_items
  has_many :search_term_report_items
end
