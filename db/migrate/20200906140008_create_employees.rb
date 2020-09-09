class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :surname
      t.string :role
      t.integer :payrole
      t.integer :telephone

      t.timestamps
    end
  end
end
