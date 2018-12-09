class AdvertisedProductReportItem < ApplicationRecord
  belongs_to :ad_group
  belongs_to :sku
  belongs_to :report
end
