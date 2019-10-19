require "application_system_test_case"

class CalculationsTest < ApplicationSystemTestCase
  setup do
    @calculation = calculations(:one)
  end

  test "visiting the index" do
    visit calculations_url
    assert_selector "h1", text: "Calculations"
  end

  test "creating a Calculation" do
    visit calculations_url
    click_on "New Calculation"

    fill_in "Annual income", with: @calculation.annual_income
    fill_in "Capital gains", with: @calculation.capital_gains
    fill_in "Deduction", with: @calculation.deduction
    fill_in "Dependent children", with: @calculation.dependent_children
    click_on "Create Calculation"

    assert_text "Calculation was successfully created"
    click_on "Back"
  end

  test "updating a Calculation" do
    visit calculations_url
    click_on "Edit", match: :first

    fill_in "Annual income", with: @calculation.annual_income
    fill_in "Capital gains", with: @calculation.capital_gains
    fill_in "Deduction", with: @calculation.deduction
    fill_in "Dependent children", with: @calculation.dependent_children
    click_on "Update Calculation"

    assert_text "Calculation was successfully updated"
    click_on "Back"
  end

  test "destroying a Calculation" do
    visit calculations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Calculation was successfully destroyed"
  end
end
