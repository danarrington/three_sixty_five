class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.decimal :distance
      t.integer :run_type
      t.integer :season_id

      t.timestamps
    end
  end
end
