class AddTotalDistanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :total_distance, :decimal, precision: 5, scale: 2, default: 0, null: false
  end
end
