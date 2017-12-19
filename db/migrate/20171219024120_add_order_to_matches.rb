class AddOrderToMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :order, :integer
  end
end
