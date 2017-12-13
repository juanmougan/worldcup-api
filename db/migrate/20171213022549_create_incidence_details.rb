class CreateIncidenceDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :incidence_details do |t|
      t.string :detail
      t.integer :incidence

      t.timestamps
    end
  end
end
