class AddRundateToRun < ActiveRecord::Migration
  def change
    add_column :runs, :run_date, :date
  end
end
