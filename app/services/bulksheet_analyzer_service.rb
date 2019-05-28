class BulksheetAnalyzerService
  OLD_FORMAT = ['Sponsored Products Campaigns', 'Headline Search Campaigns', 'Portfolios'].freeze
  NEW_FORMAT = ['Sponsored Products Campaigns', 'Sponsored Brands Campaigns', 'Portfolios'].freeze

  def initialize(bulksheet)
    @bulksheet = bulksheet
  end

  def call
    xlsx = instantiate_file

    @bulksheet.update(
      file_format_valid: check_bulksheet_format(xlsx.sheets),
      analyzed_at: Time.current
    )

    OpenStruct.new(success?: true, error: nil, bulksheet: @bulksheet)
  rescue StandardError => e
    OpenStruct.new(success?: false, error: e.message, bulksheet: nil)
  end

  private

  def instantiate_file
    Roo::Spreadsheet.open(
      ActiveStorage::Blob.service.send(:path_for, @bulksheet.file.key),
      extension: :xlsx
    )
  end

  def check_bulksheet_format(sheets)
    (OLD_FORMAT - sheets).empty? || (NEW_FORMAT - sheets).empty?
  end
end
