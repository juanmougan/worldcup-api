class CreateIncidences < ActiveRecord::Migration[5.1]
  def change
    create_table :incidences do |t|
      t.belongs_to :player, foreign_key: true
      t.belongs_to :match, foreign_key: true
      t.integer :incidence_type
      t.integer :status

      t.timestamps
    end
  end
end
