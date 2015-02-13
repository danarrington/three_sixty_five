class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :name
      t.string :text

      t.timestamps
    end

    add_column :users, :last_announcement_id, :integer

  end
end
