require 'test_helper'

class ReportAnalyzerServiceTest < ActiveSupport::TestCase
  setup do
    @report = reports(:two)
    @service = ReportAnalyzerService.new(
      @report,
      file_data('report.xlsx')
    )
  end
  test 'should analyze report file' do
    result = @service.call

    # assert @service.success?
    puts result.error
    # refute @report.imported?
    #
    # @new_report.import!
    #
    # assert @report.imported?
  end
end
