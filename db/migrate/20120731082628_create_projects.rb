class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :environment
      t.string :reports_home
      t.string :platform

      t.timestamps
    end
  end
end
