require 'test_helper'

class PunchiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @punchy = punchies(:one)
  end

  test "should get index" do
    get punchies_url
    assert_response :success
  end

  test "should get new" do
    get new_punchy_url
    assert_response :success
  end

  test "should create punchy" do
    assert_difference('Punchy.count') do
      post punchies_url, params: { punchy: { name: @punchy.name, timePunchIn: @punchy.timePunchIn, timePunchOut: @punchy.timePunchOut, user_id: @punchy.user_id } }
    end

    assert_redirected_to punchy_url(Punchy.last)
  end

  test "should show punchy" do
    get punchy_url(@punchy)
    assert_response :success
  end

  test "should get edit" do
    get edit_punchy_url(@punchy)
    assert_response :success
  end

  test "should update punchy" do
    patch punchy_url(@punchy), params: { punchy: { name: @punchy.name, timePunchIn: @punchy.timePunchIn, timePunchOut: @punchy.timePunchOut, user_id: @punchy.user_id } }
    assert_redirected_to punchy_url(@punchy)
  end

  test "should destroy punchy" do
    assert_difference('Punchy.count', -1) do
      delete punchy_url(@punchy)
    end

    assert_redirected_to punchies_url
  end
end
