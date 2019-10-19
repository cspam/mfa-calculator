class CalculationService
  def initialize(annual_income, capital_gains, deduction, dependent_children)
    @annual_income = annual_income
    @capital_gains = capital_gains
    @deduction = deduction
    @dependent_children = dependent_children
  end

  def get_m4a_2020_cost
    return 0 # lol
  end

  def get_current_hellworld_cost
    return 1_000_000 # also lol except that it's real
  end

  def get_arbitrary_sample_calculation
    # access parameters by just using @whatever_parameter_you_want
    return (@annual_income - @deduction) * 0.20
  end

  def create_arbitrary_hash
    # this should probably be stored in some sort of constants file, but just for demonstration purposes,
    # we can keep hashes or tables here if we want
    kids_and_tax_rates = {
      0 => 0.5,
      1 => 0.45,
      2 => 0.3
    }
    return kids_and_tax_rates
  end

  def use_arbitrary_hash
    tax_rate_hash = create_arbitrary_hash

    # the || bars here are a fallback.  for example, if i have 10 kids, the rate is 0.2
    my_tax_rate = tax_rate_hash[@dependent_children] || 0.2
  end
end