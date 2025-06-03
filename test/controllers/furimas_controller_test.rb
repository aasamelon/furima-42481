require "test_helper"

class FurimasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get furimas_index_url
    assert_response :success
  end
end
