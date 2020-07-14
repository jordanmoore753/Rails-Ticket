class AddCreatorToTickets < ActiveRecord::Migration[6.0]
  def change
    add_reference :tickets, :user
  end
end
