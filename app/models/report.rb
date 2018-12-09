class Report < ApplicationRecord
  has_one_attached :file

  def self.importable?
    false
  end

  def importable?
    self.class.importable?
  end

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

  def import!
    return unless
      importable? &&
      analyzed? &&
      file_format_valid? &&
      !imported?
    klass = (self.class.name + 'Importer').constantize
    klass.new(self).import!
  end
end
