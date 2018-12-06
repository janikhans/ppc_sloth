require 'test_helper'

class SearchTermReportCsvImporterTest < ActiveSupport::TestCase
  setup do
    @report = reports(:one)
    @existing_report = SearchTermReportCsvImporter.new(
      path: file_data('existing_report.csv'),
      report: @report
    )

    @new_report = SearchTermReportCsvImporter.new(
      path: file_data('new_report.csv'),
      report: @report
    )
  end
  test 'should import report' do
    refute @report.imported?

    @new_report.import!

    assert @report.imported?
  end

  test 'should create new campaign' do
    assert_differences [['Campaign.count', 1]] do
      @new_report.import!
    end
  end

  test 'should find existing campaign' do
    assert_differences [['Campaign.count', 0]] do
      @existing_report.import!
    end
  end

  test 'should create new ad group' do
    assert_differences [['AdGroup.count', 1]] do
      @new_report.import!
    end
  end

  test 'should find existing ad group' do
    assert_differences [['AdGroup.count', 0]] do
      @existing_report.import!
    end
  end

  test 'should create new keyword' do
    assert_differences [['Keyword.count', 1]] do
      @new_report.import!
    end
  end

  test 'should find existing keyword' do
    assert_differences [['Keyword.count', 0]] do
      @existing_report.import!
    end
  end

  test 'should create new search term' do
    assert_differences [['SearchTerm.count', 1]] do
      @new_report.import!
    end
  end

  test 'should find existing search term' do
    assert_differences [['SearchTerm.count', 0]] do
      @existing_report.import!
    end
  end

  test 'should create search term report item' do
    assert_differences [['SearchTermReportItem.count', 1]] do
      @new_report.import!
    end
  end
end
