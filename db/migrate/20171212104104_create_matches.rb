class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.references :home_team, foreign_key: true
      t.references :away_team, foreign_key: true
      t.string :home_goals
      t.string :integer
      t.string :away_score
      t.string :integer
      t.string :round
      t.string :references

      t.timestamps
    end
  end
end
