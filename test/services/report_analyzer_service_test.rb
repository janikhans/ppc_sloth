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
end
