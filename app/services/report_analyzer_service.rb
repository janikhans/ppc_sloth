class ReportAnalyzerService
  def initialize(report)
    @report = report
  end

  def call
    instantiate_file
    determine_period
    update_report

    OpenStruct.new(success?: true, error: nil, report: @report)
  rescue StandardError => e
    OpenStruct.new(success?: false, error: e.message, report: nil)
  end

  private

  def instantiate_file
    @xlsx = Roo::Spreadsheet.open(
      ActiveStorage::Blob.service.send(:path_for, @report.file.key),
      extension: :xlsx
    )
  end

  def determine_period
    dates = @xlsx.column(1)[1..-1].sort!
    @period_start = dates.first
    @period_end = dates.last
  end

  def report_type
    case @xlsx.sheets
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
      # shit
    end
  end

  def update_report
    @report.update(
      type: report_type,
      period_start: @period_start,
      period_end: @period_end,
      analyzed_at: Time.current
    )
  end
end
