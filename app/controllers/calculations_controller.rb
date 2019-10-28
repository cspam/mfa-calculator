class CalculationsController < ApplicationController
  before_action :set_calculation, only: [:show, :edit, :update, :destroy]
  before_action :check_token, only: [:edit]
  before_action :check_referer, only: [:update]
  before_action :prevent, only: [:index, :delete]

  # GET /calculations
  # GET /calculations.json
  def index
    @calculations = Calculation.all
  end

  # GET /calculations/1
  # GET /calculations/1.json
  def show
    cs = CalculationService.new(@calculation.annual_income,
                                @calculation.capital_gains,
                                @calculation.deduction,
                                @calculation.dependent_children)

    filing_type = @calculation.filing_type.to_sym

    @new_total_taxes = cs.new_total_taxes(filing_type)
    @old_total_taxes = cs.old_total_taxes(filing_type)
    @tax_difference = @old_total_taxes - @new_total_taxes

    @old_expenses = (12 * @calculation.monthly_insurance_premium) + @calculation.annual_out_of_pocket_costs +
                 @calculation.annual_dental_costs + @calculation.annual_vision_costs +
                 @calculation.annual_hearing_costs + @calculation.annual_drug_costs
    @new_expenses = [@calculation.annual_drug_costs || 0, 200].min
    @expenses_difference = @old_expenses - @new_expenses

    @old_total = @old_total_taxes + @old_expenses
    @new_total = @new_total_taxes + @new_expenses
    @total_difference = @old_total - @new_total
  end

  # GET /calculations/new
  def new
    @calculation = Calculation.new
  end

  # GET /calculations/1/edit
  def edit
  end

  # POST /calculations
  # POST /calculations.json
  def create
    @calculation = Calculation.new(calculation_params)

    respond_to do |format|
      if @calculation.save
        format.html { redirect_to calculation_path(@calculation, token: @calculation.edit_token) }
        format.json { render :show, status: :created, location: @calculation }
      else
        format.html { render :new }
        format.json { render json: @calculation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calculations/1
  # PATCH/PUT /calculations/1.json
  def update
    respond_to do |format|
      if @calculation.update(calculation_params)
        format.html { redirect_to calculation_path(@calculation, token: @calculation.edit_token) }
        format.json { render :show, status: :ok, location: @calculation }
      else
        format.html { render :edit }
        format.json { render json: @calculation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calculations/1
  # DELETE /calculations/1.json
  def destroy
    @calculation.destroy
    respond_to do |format|
      format.html { redirect_to calculations_url, notice: 'Calculation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calculation
      @calculation = Calculation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calculation_params
      pp = params.require(:calculation).permit(:annual_income, :capital_gains, :deduction, :dependent_children,
        :monthly_insurance_premium, :filing_type, :annual_out_of_pocket_costs,
        :annual_dental_costs, :annual_vision_costs, :annual_hearing_costs, :annual_drug_costs)
      pp[:filing_type] = params[:calculation][:filing_type].to_i if params[:calculation] && params[:calculation][:filing_type]
      pp
    end

    def prevent
      redirect_back(fallback_location: root_path, alert: "You're not allowed to take that action")
    end

    def check_token
      unless params[:token] == @calculation.edit_token
        redirect_back(fallback_location: root_path, alert: "You're not allowed to take that action")
      end
    end

    def check_referer
      unless request.referer.last(32) == @calculation.edit_token
        redirect_back(fallback_location: root_path, alert: "You're not allowed to take that action")
      end
    end
end
