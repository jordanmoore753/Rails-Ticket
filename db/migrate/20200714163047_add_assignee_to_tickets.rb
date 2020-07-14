class AddAssigneeToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :assignee, :integer
    add_foreign_key :tickets, :users, column: :assignee, on_delete: :cascade
  end
end
