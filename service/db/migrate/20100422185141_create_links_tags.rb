class CreateLinksTags < ActiveRecord::Migration
  def self.up
    create_table :links_tags, :id => false do |table|
      table.references :link, :tag, :null => false
    end
    add_index :links_tags, [:link_id, :tag_id]
    add_index :links_tags, [:tag_id, :link_id]
  end

  def self.down
    drop_table :links_tags
  end
end
