class AddImages < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :images, :json
  end
end
