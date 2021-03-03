require "test_helper"

class FiltersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get filters_edit_url
    assert_response :success
  end

  test "should get new" do
    get filters_new_url
    assert_response :success
  end
end
