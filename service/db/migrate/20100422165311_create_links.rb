class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :url, :limit => 500, :null => false
      t.string :title, :limit => 250, :null => false
      t.text :notes, :limit => 5000
      t.timestamps
    end
    add_index :links, :url, :unique => true
  end

  def self.down
    drop_table :links
  end
end
