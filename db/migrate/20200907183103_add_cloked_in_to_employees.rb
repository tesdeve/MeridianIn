class AddClokedInToEmployees < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :clockedin, :string
  end
end
