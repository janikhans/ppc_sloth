class Ad < ApplicationRecord
  include Statusable
  
  belongs_to :sku
  validates :sku, presence: true

  belongs_to :ad_group
  validates :ad_group, presence: true
end
