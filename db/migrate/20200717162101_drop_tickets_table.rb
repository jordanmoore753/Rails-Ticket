class DropTicketsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table(:tickets)
  end
end
