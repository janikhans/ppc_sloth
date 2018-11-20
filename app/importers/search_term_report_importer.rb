class SearchTermReportImporter
  include CSVParty
  depends_on :search_term_report

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
  end

  rows do |row|
    item = search_term_report.items.find_or_initialize_by(
      ad_group: row.ad_group,
      keyword: row.keyword,
      search_term: row.search_term,
      date: row.date
    )

    item.assign_attributes(
      currency: row.currency,
      impressions: row.impressions,
      clicks: row.clicks
    )

    row.campaign.save if row.campaign.new_record?
    row.search_term.save if row.search_term.new_record?
    item.save if item.changed?

    search_term_report.update(imported: Time.current)
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


# Date,Currency,Campaign Name,Ad Group Name,Targeting,Match Type,Customer Search Term,Impressions,Clicks,
# Click-Thru Rate (CTR),Cost Per Click (CPC),Spend,7 Day Total Sales ,Total Advertising Cost of Sales (ACoS) ,Total Return on Advertising Spend (RoAS),7 Day Total Orders (#),7 Day Total Units (#),7 Day Conversion Rate,7 Day Advertised SKU Units (#),7 Day Other SKU Units (#),7 Day Advertised SKU Sales ,7 Day Other SKU Sales
