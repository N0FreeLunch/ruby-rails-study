require "test_helper"

class ViewToDisplayControllerTest < ActionDispatch::IntegrationTest
  test "should get sampleView" do
    get view_to_display_sampleView_url
    assert_response :success
  end
end
