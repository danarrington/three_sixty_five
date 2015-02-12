class CreateFeatureAnnouncments < ActiveRecord::Migration
  def change
    create_table :feature_announcments do |t|
      t.string :name
      t.string :text

      t.timestamps
    end
  end
end
