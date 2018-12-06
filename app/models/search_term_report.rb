class SearchTermReport < Report
  has_many :items,
    class_name: 'SearchTermReportItem',
    foreign_key: :report_id

  def import!
    return unless analyzed?
    return if imported?
    SearchTermReportImporter.new(self).import!
  end
end
