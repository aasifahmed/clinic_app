class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    @appointments = Appointment.all
    @sex = {false => 'Female', true => 'Male'}
  end

  def search
    @doctor = Doctor.all
    @result = @appointments
    @visit = Appointment.pluck(:visit_type).uniq
    @nation = Appointment.pluck(:nationality).uniq
  end

  def search_result
    @sex = {false => 'Female', true => 'Male'}
    @sex = {false => 'Female', true => 'Male'}
    @appointments = Appointment.includes(:insurance_company, :doctor).where(nil) # creates an anonymous scope
    @appointments = @appointments.file_no(params[:file_no]) if params[:file_no].present?
    @appointments = @appointments.age(params[:age]) if params[:age].present?
    @appointments = @appointments.sex(params[:sex]) if params[:sex].present?
    @appointments = @appointments.nationality(params[:nationality]) if params[:nationality].present?
    @appointments = @appointments.visit_type(params[:visit_type]) if params[:visit_type].present?
    @appointments = @appointments.cash(params[:cash]) if params[:cash].present?
    @appointments = @appointments.by_doctor(params[:doctor_id]) if params[:doctor_id].present?
    @appointments = @appointments.appointment_time_between(params[:min_time], params[:max_time]) if (params[:min_time].present? and params[:max_time].present?)    
    @result = @appointments.length
    @male_count = @appointments.where(sex: true)
    @female_count = @appointments.where(sex: false)
    @new_visit_count = @appointments.where(visit_type: 'New')
    @old_visit_count = @appointments.where(visit_type: 'Old')
    @revisit_count = @appointments.where(visit_type: 'Revisit')
    @cash = @appointments.where(insurance_company_id: nil)
    @insurance = @appointments.where.not(insurance_company_id: nil)
    @national = @appointments.where(nationality: 'INDIAN')
    @other_national = @appointments.where('nationality !=  ?', "INDIAN")
    @toddlers = @appointments.where('age <= ?', 10)
    @teen = @appointments.where('age > ? AND age <= ?', 10, 20)
    @youth = @appointments.where('age > ? AND age <= ?', 20, 30)
    @adult = @appointments.where('age > ? AND age <= ?', 30, 40)
    @middle = @appointments.where('age > ? AND age <= ?', 40, 50)
    @mature = @appointments.where('age > ? AND age <= ?', 50, 60)
    @old = @appointments.where('age > ? AND age <= ?', 60, 70)
    @grand = @appointments.where('age >= ?', 71)
    @sun = @appointments.where('appointment_time > ? AND appointment_time <= ?', "2017-02-04 02:11:00", "2017-02-04 23:01:00")
    render 'index'
  end
  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:patient_name, :appointment_time, :file_no, :age, :sex, :nationality, :visit_type, :cash, :insurance_company_id, :doctor_id)
    end
end
