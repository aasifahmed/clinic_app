class InsuranceCompaniesController < ApplicationController
  before_action :set_insurance_company, only: [:show, :edit, :update, :destroy]

  # GET /insurance_companies
  # GET /insurance_companies.json
  def index
    @insurance_companies = InsuranceCompany.all
  end

  # GET /insurance_companies/1
  # GET /insurance_companies/1.json
  def show
  end

  # GET /insurance_companies/new
  def new
    @insurance_company = InsuranceCompany.new
  end

  # GET /insurance_companies/1/edit
  def edit
  end

  # POST /insurance_companies
  # POST /insurance_companies.json
  def create
    @insurance_company = InsuranceCompany.new(insurance_company_params)

    respond_to do |format|
      if @insurance_company.save
        format.html { redirect_to @insurance_company, notice: 'Insurance company was successfully created.' }
        format.json { render :show, status: :created, location: @insurance_company }
      else
        format.html { render :new }
        format.json { render json: @insurance_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurance_companies/1
  # PATCH/PUT /insurance_companies/1.json
  def update
    respond_to do |format|
      if @insurance_company.update(insurance_company_params)
        format.html { redirect_to @insurance_company, notice: 'Insurance company was successfully updated.' }
        format.json { render :show, status: :ok, location: @insurance_company }
      else
        format.html { render :edit }
        format.json { render json: @insurance_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_companies/1
  # DELETE /insurance_companies/1.json
  def destroy
    @insurance_company.destroy
    respond_to do |format|
      format.html { redirect_to insurance_companies_url, notice: 'Insurance company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance_company
      @insurance_company = InsuranceCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insurance_company_params
      params.require(:insurance_company).permit(:name)
    end
end
