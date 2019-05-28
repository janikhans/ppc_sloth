class BulksheetImporter
  attr_accessor :campaign, :ad_group, :ad, :keyword

  def initialize(bulksheet)
    @bulksheet = bulksheet
  end

  def import!
    xlsx = instantiate_file

    xlsx.parse(headers: true)[1..-1].each do |row|
      case row['Record Type']
      when 'Campaign'
        create_or_find_campaign(row)
      when 'Ad Group'
        create_or_find_ad_group(row)
      when 'Ad'
        create_or_find_ad(row)
      when 'Keyword'
        create_or_find_keyword(row)
      else
        # hmmm
      end
    end

    @bulksheet.update(
      imported_at: Time.current
    )
  end

  private

  def instantiate_file
    Roo::Spreadsheet.open(
      ActiveStorage::Blob.service.send(:path_for, @bulksheet.file.key),
      extension: :xlsx
    )
  end

  def parse_for_enum(value)
    return if value.blank?
    return 'dash' if value == '-'

    value.underscore.tr(' ', '_')
  end

  def create_or_find_campaign(row)
    self.campaign = Campaign.find_by(amazon_id: row['Record ID']) ||
                    Campaign.find_or_initialize_by(name: row['Campaign'])
    campaign.amazon_id = row['Record ID']
    campaign.targeting_type = parse_for_enum(row['Campaign Targeting Type'])
    campaign.status = parse_for_enum(row['Campaign Status'])
    campaign.save
  end

  def create_or_find_ad_group(row)
    self.ad_group = campaign.ad_groups.find_by(amazon_id: row['Record ID']) ||
                    campaign.ad_groups.find_or_initialize_by(name: row['Ad Group'])
    ad_group.amazon_id = row['Record ID']
    ad_group.status = parse_for_enum(row['Ad Group Status'])
    ad_group.save
  end

  def create_or_find_ad(row)
    self.ad = ad_group.ads.find_by(amazon_id: row['Record ID']) ||
              ad_group.ads.find_or_initialize_by(sku: Sku.find_or_initialize_by(name: row['SKU']))
    ad.status = parse_for_enum(row['Status'])
    ad.save
  end

  def create_or_find_keyword(row)
    return if row['Ad Group'].blank? # Means this is a campaign Negative Keyword

    self.keyword = ad_group.keywords.find_by(amazon_id: row['Record ID']) ||
                   ad_group.keywords.find_or_initialize_by(
                     text: row['Keyword or Product Targeting'],
                     match_type: parse_for_enum(row['Match Type'])
                   )
    keyword.amazon_id = row['Record ID']
    keyword.status = parse_for_enum(row['Status'])
    keyword.save
  end
end
