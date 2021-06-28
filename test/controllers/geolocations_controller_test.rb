require 'test_helper'

class GeolocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @geolocation = geolocations(:one)
  end

  test "should get index" do
    get geolocations_url
    assert_response :success
  end

  test "should get new" do
    get new_geolocation_url
    assert_response :success
  end

  test "should create geolocation" do
    assert_difference('Geolocation.count') do
      post geolocations_url, params: { geolocation: {  } }
    end

    assert_redirected_to geolocation_url(Geolocation.last)
  end

  test "should show geolocation" do
    get geolocation_url(@geolocation)
    assert_response :success
  end

  test "should get edit" do
    get edit_geolocation_url(@geolocation)
    assert_response :success
  end

  test "should update geolocation" do
    patch geolocation_url(@geolocation), params: { geolocation: {  } }
    assert_redirected_to geolocation_url(@geolocation)
  end

  test "should destroy geolocation" do
    assert_difference('Geolocation.count', -1) do
      delete geolocation_url(@geolocation)
    end

    assert_redirected_to geolocations_url
  end
end
