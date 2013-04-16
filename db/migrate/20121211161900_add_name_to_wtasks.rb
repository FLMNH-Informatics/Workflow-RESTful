class AddNameToWtasks < ActiveRecord::Migration
  def change
    add_column :wtasks, :wtask_status, :string
    add_column :wtasks, :wtask_folder, :string
  end
end
