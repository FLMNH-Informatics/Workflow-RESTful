class AddNameToWflows < ActiveRecord::Migration
  def change
    add_column :wflows, :wstatus, :string
    add_column :wflows, :wfolder, :string
  end
end
