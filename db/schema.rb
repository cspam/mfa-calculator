# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_19_165755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calculations", force: :cascade do |t|
    t.integer "annual_income", null: false
    t.integer "capital_gains", null: false
    t.integer "deduction", null: false
    t.integer "dependent_children", null: false
    t.integer "monthly_insurance_premium", null: false
    t.integer "filing_type", null: false
    t.integer "annual_out_of_pocket_costs", null: false
    t.integer "annual_dental_costs", null: false
    t.integer "annual_vision_costs", null: false
    t.integer "annual_hearing_costs", null: false
    t.integer "annual_drug_costs", null: false
    t.string "edit_token", limit: 32, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
