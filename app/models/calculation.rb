class Calculation < ApplicationRecord
  validates :annual_income, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :capital_gains, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :deduction, presence: true, numericality: { greater_than_or_equal_to: 0, allow_blank: true }
  validates :dependent_children, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 30 }
  validates :monthly_insurance_premium, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :filing_type, presence: true
  validates :annual_out_of_pocket_costs, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :annual_dental_costs, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :annual_vision_costs, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :annual_hearing_costs, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :annual_drug_costs, presence: true, numericality: { greater_than_or_equal_to: 0 }

  enum filing_type: { single: 0, married_joint: 1, married_single: 2, head_of_household: 3 }

  before_save :fix_deduction
  before_create :create_edit_token

  def fix_deduction
    self.deduction = 0 unless deduction
  end

  def create_edit_token
    self.edit_token = SecureRandom.base58(32)
  end

end
