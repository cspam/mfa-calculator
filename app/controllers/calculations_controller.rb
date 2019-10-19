class CalculationsController < ApplicationController
  before_action :set_calculation, only: [:show, :edit, :update, :destroy]

  # GET /calculations
  # GET /calculations.json
  def index
    @calculations = Calculation.all
  end

  # GET /calculations/1
  # GET /calculations/1.json
  def show
    # NOTES: You can access the information at this point like:
    # @calculation.annual_income
    # @calculation.capital_gains
    # @calculation.deduction
    # @calculation.dependent_children

    # to keep controller small, we create a service object, which lives in app/services/calculation_service.rb,
    # and put the bulk of the logic in there
    cs = CalculationService.new(@calculation.annual_income, @calculation.capital_gains, @calculation.deduction, @calculation.dependent_children)

    # just some demonstrative examples
    @m4a_cost = cs.get_m4a_2020_cost
    @current_cost = cs.get_current_hellworld_cost

    # these variables can now be displayed in the page just by using @the_variable_name_you_want
    # (note that the #create action we are in renders app/views/calculations/show.html.slim)
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
        format.html { redirect_to @calculation, notice: 'Calculation was successfully created.' }
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
        format.html { redirect_to @calculation, notice: 'Calculation was successfully updated.' }
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
      params.require(:calculation).permit(:annual_income, :capital_gains, :deduction, :dependent_children)
    end
end
