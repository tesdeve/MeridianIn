class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :surname
      t.bigint :payroll
      t.string :role
      t.bigint :telephone

      t.boolean :clocked_in,   :default => false, :null => false
      t.integer :status, index: true
      t.datetime :clocked_at
      t.timestamps
    end
  end
end
