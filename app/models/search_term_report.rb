class SearchTermReport < Report
  has_many :items,
    class_name: 'SearchTermReportItem',
    foreign_key: :report_id

  def import!
    return if imported?
    SearchTermReportImporter.new(
      path: ActiveStorage::Blob.service.send(:path_for, file.key),
      report: self
    ).import!
  end
end
