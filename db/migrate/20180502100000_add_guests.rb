class AddGuests < ActiveRecord::Migration[5.0]
  def change
   add_column :reservations, :guest_number, :integer


  end
end
