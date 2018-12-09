require 'test_helper'

class ReportAnalyzerServiceTest < ActiveSupport::TestCase
  setup do
    @report = reports(:three)
  end

  test 'should correctly analyze report types' do
    files = [
      'advertised_product_report.xlsx', 'performance_over_time_report.xlsx', 'placement_report.xlsx',
      'purchased_product_report.xlsx', 'search_term_report.xlsx', 'targeting_report.xlsx'
    ]

    files.each do |file|
      @report.file.attach(io: File.open(file_data(file)), filename: file)

      ReportAnalyzerService.new(@report).call

      assert_equal @report.type, file.gsub('.xlsx', '').camelize
    end
  end

  test 'should correctly identify wrong report type' do
    file = 'bulksheet.xlsx'
    @report.file.attach(io: File.open(file_data(file)), filename: file)

    assert_not_equal @report.type, 'UnknownReport'

    ReportAnalyzerService.new(@report).call

    assert_equal @report.type, 'UnknownReport'
  end

  test 'should correctly identify wrong aggregation type' do
    file = 'invalid_total_aggregation.xlsx'
    @report.file.attach(io: File.open(file_data(file)), filename: file)

    assert_nil @report.file_errors
    assert_nil @report.file_format_valid

    ReportAnalyzerService.new(@report).call

    assert_not_nil @report.file_errors
    assert_not_nil @report.file_format_valid
  end
end
