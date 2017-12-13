class AddHomeTeamAndAwayTeamToMatches < ActiveRecord::Migration[5.1]
  def change
    add_reference :matches, :home_team, index: true
    add_reference :matches, :away_team, index: true

    add_foreign_key :matches, :teams, column: :home_team_id
    add_foreign_key :matches, :teams, column: :away_team_id
  end
end
