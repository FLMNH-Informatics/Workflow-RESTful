class CreateWtaskPorts < ActiveRecord::Migration
  def self.up
    create_table :wtask_ports do |t|
      t.integer :wtask_id
      t.integer :ptype
      t.text :ploc
      t.timestamps
    end
  end

  def self.down
    drop_table :wtask_ports
  end
end
