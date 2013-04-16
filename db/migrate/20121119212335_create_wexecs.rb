class CreateWexecs < ActiveRecord::Migration
  def self.up
    create_table :wexecs do |t|
      t.string :name
      t.text :eloc
      t.timestamps
    end
  end

  def self.down
    drop_table :wexecs
  end
end
