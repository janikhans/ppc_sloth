require 'test_helper'

class BulksheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulksheet = bulksheets(:one)
  end

  test "should get index" do
    get bulksheets_url
    assert_response :success
  end

  test "should get new" do
    get new_bulksheet_url
    assert_response :success
  end

  test "should create bulksheet" do
    assert_difference('Bulksheet.count') do
      post bulksheets_url, params: { bulksheet: { analyzed_at: @bulksheet.analyzed_at, imported_at: @bulksheet.imported_at } }
    end

    assert_redirected_to bulksheet_url(Bulksheet.last)
  end

  test "should show bulksheet" do
    get bulksheet_url(@bulksheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_bulksheet_url(@bulksheet)
    assert_response :success
  end

  test "should update bulksheet" do
    patch bulksheet_url(@bulksheet), params: { bulksheet: { analyzed_at: @bulksheet.analyzed_at, imported_at: @bulksheet.imported_at } }
    assert_redirected_to bulksheet_url(@bulksheet)
  end

  test "should destroy bulksheet" do
    assert_difference('Bulksheet.count', -1) do
      delete bulksheet_url(@bulksheet)
    end

    assert_redirected_to bulksheets_url
  end
end
