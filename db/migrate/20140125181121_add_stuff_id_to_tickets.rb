class AddStuffIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :staff_id, :integer
  end
end
