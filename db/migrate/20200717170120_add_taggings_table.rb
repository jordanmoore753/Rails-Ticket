class AddTaggingsTable < ActiveRecord::Migration[6.0]
  def change
    create_table "taggings", force: :cascade do |t|
      t.bigint "ticket_id"
      t.bigint "tag_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["tag_id"], name: "index_taggings_on_tag_id"
      t.index ["ticket_id"], name: "index_taggings_on_ticket_id"
    end
  end
end
