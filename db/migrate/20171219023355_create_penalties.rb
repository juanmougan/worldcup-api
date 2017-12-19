class CreatePenalties < ActiveRecord::Migration[5.1]
  def change
    create_table :penalties do |t|
      t.belongs_to :player, foreign_key: true
      t.belongs_to :match, foreign_key: true
      t.integer :length
      t.integer :status

      t.timestamps
    end
  end
end
