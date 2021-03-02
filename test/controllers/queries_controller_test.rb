require "test_helper"

class QueriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get queries_index_url
    assert_response :success
  end

  test "should get show" do
    get queries_show_url
    assert_response :success
  end

  test "should get new" do
    get queries_new_url
    assert_response :success
  end

  test "should get edit" do
    get queries_edit_url
    assert_response :success
  end
end
