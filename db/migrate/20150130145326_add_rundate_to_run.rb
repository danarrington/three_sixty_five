class AddRundateToRun < ActiveRecord::Migration
  def change
    add_column :runs, :run_date, :datetime
  end
end
