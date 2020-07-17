class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments, force: :cascade do |t|
      t.string 'body', null: false
      t.bigint 'creator_id', null: false
      t.bigint 'ticket_id', null: false
      t.index ['creator_id'], name: 'index_comments_on_creator_id'
      t.index ['ticket_id'], name: 'index_comments_on_ticket_id'
      t.timestamps
    end

    add_foreign_key "comments", "tickets", column: "ticket_id"
    add_foreign_key "comments", "users", column: "creator_id"
  end
end
