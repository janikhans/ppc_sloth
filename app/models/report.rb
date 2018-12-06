class Report < ApplicationRecord
  has_one_attached :file

  has_many :items, class_name: 'SearchTermReportItem'

  def imported?
    imported.present?
  end

  def filename
    file.blob.filename
  end

  def import!
    return if imported?
    SearchTermReportImporter.new(
      path: ActiveStorage::Blob.service.send(:path_for, file.key),
      report: self
    ).import!
  end
end
