class AddForeignKeysToTaggings < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "taggings", "tags"
    add_foreign_key "taggings", "tickets"
  end
end
