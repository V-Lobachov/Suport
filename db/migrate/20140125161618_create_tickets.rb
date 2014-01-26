class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :email
      t.string :issue
      t.string :body
      t.string :reference
      t.string :status

      t.timestamps
    end
  end
end
