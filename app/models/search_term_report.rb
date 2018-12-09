class SearchTermReport < Report
  def self.importable?
    true
  end

  has_many :items,
    class_name: 'SearchTermReportItem',
    foreign_key: :report_id
end
