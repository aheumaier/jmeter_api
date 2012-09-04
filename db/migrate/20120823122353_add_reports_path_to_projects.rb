class AddReportsPathToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :reports_home, :string
  end
end
