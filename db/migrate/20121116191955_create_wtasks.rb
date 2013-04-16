class CreateWtasks < ActiveRecord::Migration
  def self.up
    create_table :wtasks do |t|
      t.integer :wflow_id
      t.integer :exe_id
      t.text :inline
      t.timestamps
    end
  end

  def self.down
    drop_table :wtasks
  end
end
