class AddSizeToLockers < ActiveRecord::Migration[5.2]
  def change
    add_column :lockers, :size, :string
  end
end
