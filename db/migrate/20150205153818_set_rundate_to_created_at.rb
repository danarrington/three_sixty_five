class SetRundateToCreatedAt < ActiveRecord::Migration
  def self.up
    Run.update_all 'run_date = created_at'
  end
  
  def self.down
  end  
end
