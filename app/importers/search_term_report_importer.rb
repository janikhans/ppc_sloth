class SearchTermReportImporter
  include CSVParty
  depends_on :report

  column :date, header: 'Date', as: :date
  column :currency, header: 'Currency'
  column :match_type, header: 'Match Type', as: :match_type
  column :impressions, as: :integer
  column :clicks, as: :integer

  column :campaign, header: 'Campaign Name' do |value|
    Campaign.find_or_initialize_by(name: value)
  end

  column :ad_group, header: 'Ad Group Name' do |value|
    campaign.ad_groups.find_or_initialize_by(name: value)
  end

  column :keyword, header: 'Targeting' do |value|
    ad_group.keywords.find_or_initialize_by(
      text: value,
      match_type: match_type
    )
  end

  column :search_term, header: 'Customer Search Term' do |value|
    SearchTerm.find_or_initialize_by(text: value)
  end

  import do
    import_rows!
    period_start = report.items.order(date: :asc).first.date
    period_end = report.items.order(date: :desc).first.date
    report.update(
      imported_at: Time.current,
      period_start: period_start,
      period_end: period_end
    )
  end

  rows do |row|
    item = SearchTermReportItem.find_or_initialize_by(
      ad_group: row.ad_group,
      keyword: row.keyword,
      search_term: row.search_term,
      date: row.date
    )

    item.assign_attributes(
      report: report,
      currency: row.currency,
      impressions: row.impressions,
      clicks: row.clicks
    )

    row.campaign.save if row.campaign.new_record?
    row.search_term.save if row.search_term.new_record?
    item.save if item.changed?
  end

  errors do |error, line_number|
    # Eventually use ErrorModel
    puts "Row #{line_number}: #{error.message}"
  end

  private

  def parse_date(value)
    return if value.blank?
    Date.parse(value)
  end

  def parse_match_type(value)
    return if value.blank?
    value.downcase
  end
end
