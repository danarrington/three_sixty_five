class AddRuntypeToRun < ActiveRecord::Migration
  def change
    add_column :runs, :runtype, :integer
  end
end
