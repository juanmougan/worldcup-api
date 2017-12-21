class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :home_goals
      t.integer :away_score
      t.string :round

      t.timestamps
    end
  end
end
