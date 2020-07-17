class CreateTicketsTable < ActiveRecord::Migration[6.0]
  def change
    create_table "tickets", force: :cascade do |t|
      t.string "name", null: false
      t.string "body"
      t.string "status", default: "new", null: false
      t.bigint "project_id", null: false
      t.bigint "creator_id", null: false
      t.bigint "assignee_id", null: false
      t.index ["assignee_id"], name: "index_tickets_on_assignee_id"
      t.index ["creator_id"], name: "index_tickets_on_creator_id"
      t.index ["project_id"], name: "index_tickets_on_project_id"
    end
  end
end
