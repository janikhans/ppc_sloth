require 'test_helper'

class BulksheetImporterTest < ActiveSupport::TestCase
  setup do
    file = 'bulksheet.xlsx'
    @bulksheet = bulksheets(:two)
    @bulksheet.file.attach(io: File.open(file_data(file)), filename: file)
    @importer = BulksheetImporter.new(@bulksheet)
  end

  test 'should import bulksheet' do
    refute @bulksheet.imported?

    @importer.import!

    assert @bulksheet.imported?
  end

  # test 'should create new campaign' do
  #   assert_difference ['Campaign.count'] do
  #     @importer.import!
  #   end
  # end


  test 'should create things' do
    campaign_count = Campaign.count
    ad_group_count = AdGroup.count
    ad_count = Ad.count
    keyword_count = Keyword.count
    sku_count = Sku.count

    @importer.import!

    assert_not_equal campaign_count, Campaign.count
    assert_not_equal ad_group_count, AdGroup.count
    assert_not_equal ad_count, Ad.count
    assert_not_equal keyword_count, Keyword.count
    assert_not_equal sku_count, Sku.count
  end
end
