class CreateCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :calculations do |t|
      t.integer :annual_income, null: false
      t.integer :capital_gains, null: false
      t.integer :deduction, null: false
      t.integer :dependent_children, null: false

      t.timestamps
    end
  end
end
