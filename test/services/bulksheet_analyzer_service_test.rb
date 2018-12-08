require 'test_helper'

class BulksheetAnalyzerServiceTest < ActiveSupport::TestCase
  setup do
    @bulksheet = bulksheets(:three)
  end

  test 'should correctly analyze correct bulksheet' do
    file = 'bulksheet.xlsx'

    @bulksheet.file.attach(io: File.open(file_data(file)), filename: file)

    BulksheetAnalyzerService.new(@bulksheet).call

    assert @bulksheet.file_format_valid?
    assert @bulksheet.analyzed?
  end

  test 'should correctly analyze incorrect bulksheet' do
    file = 'search_term_report.xlsx'

    @bulksheet.file.attach(io: File.open(file_data(file)), filename: file)

    BulksheetAnalyzerService.new(@bulksheet).call

    refute @bulksheet.file_format_valid?
    assert @bulksheet.analyzed?
  end
end
