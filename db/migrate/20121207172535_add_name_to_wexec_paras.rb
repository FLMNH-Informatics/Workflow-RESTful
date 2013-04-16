class AddNameToWexecParas < ActiveRecord::Migration
  def change
    add_column :wexec_paras, :ptype, :string
    add_column :wexec_paras, :select_list, :string
  end
end
