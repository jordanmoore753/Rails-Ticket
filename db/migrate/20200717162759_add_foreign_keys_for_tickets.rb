class AddForeignKeysForTickets < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "taggings", "tags"
    add_foreign_key "taggings", "tickets"
    add_foreign_key "tickets", "projects"
    add_foreign_key "tickets", "users", column: "assignee_id"
    add_foreign_key "tickets", "users", column: "creator_id"
  end
end
