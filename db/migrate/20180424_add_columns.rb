class AddColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :phone, :string



  end
end
