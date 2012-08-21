class AddJtlPathToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :jtl_path, :string
  end
end
