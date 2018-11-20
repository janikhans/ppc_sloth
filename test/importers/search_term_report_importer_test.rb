require 'test_helper'

class SearchTermReportImporterTest < ActiveSupport::TestCase
  setup do
    @report = search_term_reports(:one)
    @existing_report = SearchTermReportImporter.new(
      path: file_data('existing_report.csv'),
      search_term_report: @report
    )

    @new_report = SearchTermReportImporter.new(
      path: file_data('new_report.csv'),
      search_term_report: @report
    )
  end
  test 'should process report' do
    refute @report.processed?

    @new_report.import!

    assert @report.processed?
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
