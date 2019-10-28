class CreateCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :calculations do |t|
      t.integer :annual_income, null: false
      t.integer :capital_gains, null: false
      t.integer :deduction, null: false
      t.integer :dependent_children, null: false
      t.integer :monthly_insurance_premium, null: false
      t.integer :filing_type, null: false
      t.integer :annual_out_of_pocket_costs, null: false
      t.integer :annual_dental_costs, null: false
      t.integer :annual_vision_costs, null: false
      t.integer :annual_hearing_costs, null: false
      t.integer :annual_drug_costs, null: false
      t.string :edit_token, null: false, limit: 32

      t.timestamps
    end
  end
end
