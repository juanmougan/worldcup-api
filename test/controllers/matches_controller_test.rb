require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match = matches(:one)
  end

  test "should get index" do
    get matches_url, as: :json
    assert_response :success
  end

  test "should create match" do
    assert_difference('Match.count') do
      post matches_url, params: { match: { away_score: @match.away_score, away_team_id: @match.away_team_id, home_goals: @match.home_goals, home_team_id: @match.home_team_id, integer: @match.integer, integer: @match.integer, references: @match.references, round: @match.round } }, as: :json
    end

    assert_response 201
  end

  test "should show match" do
    get match_url(@match), as: :json
    assert_response :success
  end

  test "should update match" do
    patch match_url(@match), params: { match: { away_score: @match.away_score, away_team_id: @match.away_team_id, home_goals: @match.home_goals, home_team_id: @match.home_team_id, integer: @match.integer, integer: @match.integer, references: @match.references, round: @match.round } }, as: :json
    assert_response 200
  end

  test "should destroy match" do
    assert_difference('Match.count', -1) do
      delete match_url(@match), as: :json
    end

    assert_response 204
  end
end
