class SearchTermReport < ApplicationRecord
  has_one_attached :file

  has_many :items, class_name: 'SearchTermReportItem'

  def import!
    return if processed?
    SearchTermReportImporter.new(
      path: ActiveStorage::Blob.service.send(:path_for, file.key),
      search_term_report: self
    ).import!
  end
end
