class ReportAnalyzerService
  def initialize(report)
    @report = report
  end

  def call
    xlsx = instantiate_file
    @report.type = determine_report_type(xlsx)

    unless @report.type == 'UnknownReport'
      dates = determine_dates(xlsx)
      @report.assign_attributes(
        period_start: dates.first,
        period_end: dates.last
      )
    end

    @report.analyzed_at = Time.current
    @report.save

    OpenStruct.new(success?: true, error: nil, report: @report)
  rescue StandardError => e
    OpenStruct.new(success?: false, error: e.message, report: nil)
  end

  private

  def instantiate_file
    Roo::Spreadsheet.open(
      ActiveStorage::Blob.service.send(:path_for, @report.file.key),
      extension: :xlsx
    )
  end

  def determine_dates(xlsx)
    xlsx.column(1)[1..-1].sort!
  end

  def determine_report_type(xlsx)
    case xlsx.sheets
    when ['Sponsored Product Search Term R']
      SearchTermReport
    when ['Sponsored Product Performance O']
      PerformanceOverTimeReport
    when ['Sponsored Product Purchased Pro']
      PurchasedProductReport
    when ['Sponsored Product Placement Rep']
      PlacementReport
    when ['Sponsored Product Advertised Pr']
      AdvertisedProductReport
    when ['Sponsored Product Keyword Repor']
      TargetingReport
    else
      UnknownReport
    end
  end
end
