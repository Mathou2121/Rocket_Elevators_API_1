require "application_system_test_case"

class GeolocationsTest < ApplicationSystemTestCase
  setup do
    @geolocation = geolocations(:one)
  end

  test "visiting the index" do
    visit geolocations_url
    assert_selector "h1", text: "Geolocations"
  end

  test "creating a Geolocation" do
    visit geolocations_url
    click_on "New Geolocation"

    click_on "Create Geolocation"

    assert_text "Geolocation was successfully created"
    click_on "Back"
  end

  test "updating a Geolocation" do
    visit geolocations_url
    click_on "Edit", match: :first

    click_on "Update Geolocation"

    assert_text "Geolocation was successfully updated"
    click_on "Back"
  end

  test "destroying a Geolocation" do
    visit geolocations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Geolocation was successfully destroyed"
  end
end
