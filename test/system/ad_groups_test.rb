require "application_system_test_case"

class AdGroupsTest < ApplicationSystemTestCase
  setup do
    @ad_group = ad_groups(:one)
  end

  test "visiting the index" do
    visit ad_groups_url
    assert_selector "h1", text: "Ad Groups"
  end

  test "creating a Ad group" do
    visit ad_groups_url
    click_on "New Ad Group"

    fill_in "Campaign", with: @ad_group.campaign_id
    fill_in "Name", with: @ad_group.name
    click_on "Create Ad group"

    assert_text "Ad group was successfully created"
    click_on "Back"
  end

  test "updating a Ad group" do
    visit ad_groups_url
    click_on "Edit", match: :first

    fill_in "Campaign", with: @ad_group.campaign_id
    fill_in "Name", with: @ad_group.name
    click_on "Update Ad group"

    assert_text "Ad group was successfully updated"
    click_on "Back"
  end

  test "destroying a Ad group" do
    visit ad_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ad group was successfully destroyed"
  end
end
