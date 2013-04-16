class CreateWflows < ActiveRecord::Migration
  def self.up
    create_table :wflows do |t|
      t.text :name
      t.text :desc
      t.integer :owner
      t.timestamps
    end
  end

  def self.down
    drop_table :wflows
  end
end
