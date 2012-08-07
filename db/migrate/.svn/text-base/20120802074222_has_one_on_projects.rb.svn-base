class HasOneOnProjects < ActiveRecord::Migration
  def up
   change_table :settings do |t|
      t.integer :project_id
    end
  end

  def down
    remove_column :project_id
  end
end
