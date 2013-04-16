class CreateWexecParas < ActiveRecord::Migration
  def self.up
    create_table :wexec_paras do |t|
      t.integer :wexec_id
      t.string :pname
      t.text :pcaption
      t.timestamps
    end
  end

  def self.down
    drop_table :wexec_paras
  end
end
