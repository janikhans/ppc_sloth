require "application_system_test_case"

class BulksheetsTest < ApplicationSystemTestCase
  setup do
    @bulksheet = bulksheets(:one)
  end

  test "visiting the index" do
    visit bulksheets_url
    assert_selector "h1", text: "Bulksheets"
  end

  test "creating a Bulksheet" do
    visit bulksheets_url
    click_on "New Bulksheet"

    fill_in "Analyzed At", with: @bulksheet.analyzed_at
    fill_in "Imported At", with: @bulksheet.imported_at
    click_on "Create Bulksheet"

    assert_text "Bulksheet was successfully created"
    click_on "Back"
  end

  test "updating a Bulksheet" do
    visit bulksheets_url
    click_on "Edit", match: :first

    fill_in "Analyzed At", with: @bulksheet.analyzed_at
    fill_in "Imported At", with: @bulksheet.imported_at
    click_on "Update Bulksheet"

    assert_text "Bulksheet was successfully updated"
    click_on "Back"
  end

  test "destroying a Bulksheet" do
    visit bulksheets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bulksheet was successfully destroyed"
  end
end
