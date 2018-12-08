class Bulksheet < ApplicationRecord
  has_one_attached :file

  def analyzed?
    analyzed_at.present?
  end

  def imported?
    imported_at.present?
  end

  def filename
    file.blob.filename
  end

  def analyze!
    BulksheetAnalyzerService.new(self).call
  end

  def import!
    return unless analyzed?
    return if imported?
    BulksheetImporter.new(self).import!
  end
end
