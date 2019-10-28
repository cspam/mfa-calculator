class CalculationService
  def initialize(annual_income, capital_gains, deduction, dependent_children)
    @annual_income = annual_income
    @capital_gains = capital_gains
    @deduction = deduction
    @dependent_children = dependent_children
  end

  def new_deduction_cap
    if @annual_income > DEDUCATION_CAP_AMOUNT
      return @annual_income * DEDUCATION_CAP_RATE
    else
      return @annual_income
    end
  end

  def capital_gains_limit
    return [DEDUCATION_CAP_AMOUNT - @annual_income, 0].max
  end

  def new_income
    return @annual_income + [0, @capital_gains - capital_gains_limit].max
  end

  def new_capital_gains
    return @annual_income + @capital_gains - new_income
  end

  def old_adjusted_gross_income(filing_type)
    if @deduction > 0
      amount_removed = @deduction
    else
      amount_removed = CalculationService.standard_deduction_for(filing_type)
    end

    return [@annual_income - amount_removed, 0].max
  end

  def old_adjusted_gross_income_after_children(filing_type)
    base = old_adjusted_gross_income(filing_type)
    if base < CalculationService.child_allowance_for(filing_type)
      return base - (@dependent_children * AMOUNT_PER_DEPENDENT_CHILD)
    else
      return base
    end
  end

  def old_capital_gains_tax(filing_type)
    row = CalculationService.capital_gains_table_for(filing_type).select{ |row| row[0] <= @capital_gains }.last
    return row[2] + ( (@capital_gains - row[0]) * row[1] )
  end

  def old_total_taxes(filing_type)
    base = old_adjusted_gross_income_after_children(filing_type)
    row = CalculationService.old_income_tax_table_for(filing_type).select{ |row| row[0] <= base }.last
    return row[2] + ( (base - row[0]) * row[1] ) + old_capital_gains_tax(filing_type)
  end

  def new_adjusted_gross_income(filing_type)
    if @deduction > 0
      amount_removed = [@deduction, new_deduction_cap].min
    else
      amount_removed = CalculationService.standard_deduction_for(filing_type)
    end

    return [0, @annual_income - amount_removed].max
  end

  def new_adjusted_gross_income_after_children(filing_type)
    base = new_adjusted_gross_income(filing_type)
    if base < CalculationService.child_allowance_for(filing_type)
      return base - ( @dependent_children * AMOUNT_PER_DEPENDENT_CHILD )
    else
      return base
    end
  end

  def new_taxes(filing_type)
    base = new_adjusted_gross_income_after_children(filing_type)
    row = CalculationService.new_income_tax_table_for(filing_type).select{ |row| row[0] <= base }.last
    return row[2] + ( (base - row[0]) * row[1] )
  end

  def new_personal_tax(filing_type)
    return new_adjusted_gross_income_after_children(filing_type) * NEW_PERSONAL_TAX_RATE
  end

  def new_capital_gains_tax(filing_type)
    base = new_capital_gains
    row = CalculationService.capital_gains_table_for(filing_type).select{ |row| row[0] <= base }.last
    return row[2] + ( (base - row[0]) * row[1] )
  end

  def new_total_taxes(filing_type)
    return new_capital_gains_tax(filing_type) + new_personal_tax(filing_type) + new_taxes(filing_type)
  end

  def difference(filing_type)
    return new_total_taxes(filing_type) - old_total_taxes(filing_type)
  end

  private

    def self.child_allowance_for(filing_type)
      return MARRIED_JOINT_CHILD_INCOME_CAP if filing_type == :married_joint
      return OTHER_CHILD_INCOME_CAP
    end

    def self.standard_deduction_for(filing_type)
      return SINGLE_STANDARD_DEDUCTION              if filing_type == :single
      return MARRIED_JOINT_STANDARD_DEDUCTION       if filing_type == :married_joint
      return MARRIED_SINGLE_STANDARD_DEDUCTION      if filing_type == :married_single
      return HEAD_OF_HOUSEHOLD_STANDARD_DEDUCTION   if filing_type == :head_of_household
    end

    def self.capital_gains_table_for(filing_type)
      return SINGLE_CAPITAL_GAINS_TABLE             if filing_type == :single
      return MARRIED_JOINT_CAPITAL_GAINS_TABLE      if filing_type == :married_joint
      return MARRIED_SINGLE_CAPITAL_GAINS_TABLE     if filing_type == :married_single
      return HEAD_OF_HOUSEHOLD_CAPITAL_GAINS_TABLE  if filing_type == :head_of_household
    end

    def self.old_income_tax_table_for(filing_type)
      return OLD_SINGLE_INCOME_TAX_TABLE            if filing_type == :single
      return OLD_MARRIED_JOINT_INCOME_TAX_TABLE     if filing_type == :married_joint
      return OLD_MARRIED_SINGLE_INCOME_TAX_TABLE    if filing_type == :married_single
      return OLD_HEAD_OF_HOUSEHOLD_INCOME_TAX_TABLE if filing_type == :head_of_household
    end

    def self.new_income_tax_table_for(filing_type)
      return NEW_SINGLE_INCOME_TAX_TABLE            if filing_type == :single
      return NEW_MARRIED_JOINT_INCOME_TAX_TABLE     if filing_type == :married_joint
      return NEW_MARRIED_SINGLE_INCOME_TAX_TABLE    if filing_type == :married_single
      return NEW_HEAD_OF_HOUSEHOLD_INCOME_TAX_TABLE if filing_type == :head_of_household
    end

end