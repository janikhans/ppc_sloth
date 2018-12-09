class AdvertisedProductReport < Report
  def self.importable?
    true
  end

  has_many :items,
    class_name: 'AdvertisedProductReportItem',
    foreign_key: :report_id
end
