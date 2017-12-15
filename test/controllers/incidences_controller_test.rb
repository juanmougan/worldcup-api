require 'test_helper'

class IncidencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @incidence = incidences(:one)
  end

  test "should get index" do
    get incidences_url, as: :json
    assert_response :success
  end

  test "should create incidence" do
    assert_difference('Incidence.count') do
      post incidences_url, params: { incidence: { incidence_type: @incidence.incidence_type, match_id: @incidence.match_id, player_id: @incidence.player_id, status: @incidence.status } }, as: :json
    end

    assert_response 201
  end

  test "should show incidence" do
    get incidence_url(@incidence), as: :json
    assert_response :success
  end

  test "should update incidence" do
    patch incidence_url(@incidence), params: { incidence: { incidence_type: @incidence.incidence_type, match_id: @incidence.match_id, player_id: @incidence.player_id, status: @incidence.status } }, as: :json
    assert_response 200
  end

  test "should destroy incidence" do
    assert_difference('Incidence.count', -1) do
      delete incidence_url(@incidence), as: :json
    end

    assert_response 204
  end
end
