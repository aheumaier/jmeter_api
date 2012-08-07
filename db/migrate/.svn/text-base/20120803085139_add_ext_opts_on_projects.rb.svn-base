class AddExtOptsOnProjects < ActiveRecord::Migration
  def up
    change_table :settings do |t| 
      t.text :ext_opts
    end
  end

  def down
    remove_column :ext_opts
  end
end
