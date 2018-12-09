class AdvertisedProductReportImporter
  def initialize(report)
    @report = report
  end

  def import!
    xlsx = instantiate_file

    xlsx.parse(headers: true)[1..-1].each do |row|
      @campaign = Campaign.find_or_initialize_by(name: row['Campaign Name'])
      @ad_group = @campaign.ad_groups.find_or_initialize_by(name: row['Ad Group Name'])
      @sku = Sku.find_or_initialize_by(name: row['Advertised SKU'])
      @sku.asin = row['Advertised ASIN']
      @ad = @ad_group.ads.find_or_initialize_by(sku: @sku)

      @item = AdvertisedProductReportItem.find_or_initialize_by(
        ad_group: @ad_group,
        sku: @sku,
        date: row['Date']
      )

      @item.assign_attributes(
        report: @report,
        currency: row['Currency'],
        impressions: row['Impressions'],
        clicks: row['Clicks'],
        click_through_rate: row['Click-Thru Rate (CTR)'],
        cost_per_click: parse_currency(row['Cost Per Click (CPC)']),
        spend: parse_currency(row['Spend']),
        seven_day_total_sales: parse_currency(row['7 Day Total Sales ']),
        total_advertising_cost_of_sales: parse_currency(row['Total Advertising Cost of Sales (ACoS) ']),
        total_return_on_advertising_spend: row['Total Return on Advertising Spend (RoAS)'],
        seven_day_total_orders: row['7 Day Total Orders (#)'],
        seven_day_total_units: row['7 Day Total Units (#)'],
        seven_day_conversion_rate: row['7 Day Conversion Rate'],
        seven_day_advertised_sku_units: row['7 Day Advertised SKU Units (#)'],
        seven_day_other_sku_units: row['7 Day Other SKU Units (#)'],
        seven_day_advertised_sku_sales: parse_currency(row['7 Day Advertised SKU Sales ']),
        seven_day_other_sku_sales: parse_currency(row['7 Day Other SKU Sales '])
      )

      @campaign.save
      @sku.save
      @ad.save
      @item.save
    end

    @report.update(
      imported_at: Time.current
    )
  end

  private

  def instantiate_file
    Roo::Spreadsheet.open(
      ActiveStorage::Blob.service.send(:path_for, @report.file.key),
      extension: :xlsx
    )
  end

  def parse_currency(value)
    return if value.blank?
    (value * 100).to_i
  end

  def parse_for_enum(value)
    return if value.blank?
    value.underscore.tr(' ', '_')
  end
end
