class ModifyAssigneeColumn < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tickets, :assignee_id, true
  end
end
