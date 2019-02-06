class CreateLockers < ActiveRecord::Migration[5.2]
  def change
    create_table :lockers do |t|
      t.boolean :is_available
      t.string :name

      t.timestamps
    end
  end
end
