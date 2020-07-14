class RemoveTicketIdFromTags < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :tags, :tickets
    remove_column :tags, :ticket_id, :integer
  end
end
