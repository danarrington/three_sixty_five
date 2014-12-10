class IncreaseDistancePrecision < ActiveRecord::Migration
  def change
    change_column :users, :total_distance, :decimal, precision: 6, scale: 2, default: 0, null: false
  end
end
