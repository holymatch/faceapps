require 'test_helper'

class FaceControllerTest < ActionDispatch::IntegrationTest
  test "should get recognize" do
    get face_recognize_url
    assert_response :success
  end

end
