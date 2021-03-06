# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100422185141) do

  create_table "links", :force => true do |t|
    t.string   "url",        :limit => 500,  :null => false
    t.string   "title",      :limit => 250,  :null => false
    t.text     "notes",      :limit => 5000
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["url"], :name => "index_links_on_url", :unique => true

  create_table "links_tags", :id => false, :force => true do |t|
    t.integer "link_id", :null => false
    t.integer "tag_id",  :null => false
  end

  add_index "links_tags", ["link_id", "tag_id"], :name => "index_links_tags_on_link_id_and_tag_id"
  add_index "links_tags", ["tag_id", "link_id"], :name => "index_links_tags_on_tag_id_and_link_id"

  create_table "tags", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

end
