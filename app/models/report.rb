class Report < ApplicationRecord
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
    ReportAnalyzerService.new(self).call
  end
end
