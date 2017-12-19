require 'test_helper'

class PenaltiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @penalty = penalties(:one)
  end

  test "should get index" do
    get penalties_url, as: :json
    assert_response :success
  end

  test "should create penalty" do
    assert_difference('Penalty.count') do
      post penalties_url, params: { penalty: { length: @penalty.length, match_id: @penalty.match_id, player_id: @penalty.player_id, status: @penalty.status } }, as: :json
    end

    assert_response 201
  end

  test "should show penalty" do
    get penalty_url(@penalty), as: :json
    assert_response :success
  end

  test "should update penalty" do
    patch penalty_url(@penalty), params: { penalty: { length: @penalty.length, match_id: @penalty.match_id, player_id: @penalty.player_id, status: @penalty.status } }, as: :json
    assert_response 200
  end

  test "should destroy penalty" do
    assert_difference('Penalty.count', -1) do
      delete penalty_url(@penalty), as: :json
    end

    assert_response 204
  end
end
