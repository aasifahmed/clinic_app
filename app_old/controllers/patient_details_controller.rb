class PatientDetailsController < ApplicationController
  before_action :set_patient_detail, only: [:show, :edit, :update, :destroy]

  # GET /patient_details
  # GET /patient_details.json
  def index
    @patient_details = PatientDetail.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /patient_details/1
  # GET /patient_details/1.json
  def show
  end

  def doctors_report
    @patient_details = PatientDetail.pluck(:doctor).uniq
  end

  def doctors_name
  @patient_details = PatientDetail.where("doctor like ?", "%#{params[:term]}%").pluck(:doctor).uniq
  respond_to do |format|
     format.html
     format.json { render json: @patient_details[0..10] }
     end
  end

  def payment_type
  @patient_details = PatientDetail.where("payment_mode like ?", "%#{params[:term]}%").pluck(:payment_mode).uniq
  respond_to do |format|
     format.html
     format.json { render json: @patient_details[0..10] }
     end
  end

  def nationality_name
  @patient_details = PatientDetail.where("nationality like ?", "%#{params[:term]}%").pluck(:nationality).uniq
  respond_to do |format|
     format.html
     format.json { render json: @patient_details[0..10] }
     end
  end

  # GET /patient_details/new
  def new
    @patient_detail = PatientDetail.new
  end

  def all_report
    if request.post?
      @patients_visited = Hash.new
      @all_doctors = Array.new
      @start = params[:start].to_date
      @end = params[:end].to_date

      @all_doctors = PatientDetail.pluck(:doctor).uniq

      @all_doctors.each do |doctor|
        @patients_visited[doctor] = PatientDetail.where(:doctor => doctor).where('visit_date between ? and ?', @start.to_datetime.beginning_of_day,@end.to_datetime.end_of_day).length
      end
      # @start.upto( @end) do |each_days|
      #   p "=========#{each_days}==^^^========"
      #   p @all_doctors
      #   @all_details[each_days] = PatientDetail.where('visit_date between ? and ?', each_days.to_datetime.beginning_of_day,each_days.to_datetime.end_of_day).length
      #   p @all_details[each_days]
      # end
      respond_to do |format|
          format.html { render partial: 'all_reports' }
      end
    end
  end

  def chart
      @patients_visited = Hash.new
      @all_doctors = Array.new
      @start = Time.at(2016-01-01)
      @end = Time.at(2016-12-31)

      @all_doctors = PatientDetail.pluck(:doctor).uniq

      @all_doctors.each do |doctor|
        @patients_visited[doctor] = PatientDetail.where(:doctor => doctor).length
      end
    
  end

  def patient_report
    @patients = Hash.new
    @start = params[:start].to_date
    @end = params[:end].to_date
    # @patient_details = PatientDetail.where(:visit_date  => @start..@end)
    @start.upto( @end) do |each_day|
      p "=========#{each_day}=========="
      @patients[each_day] = PatientDetail.where(:doctor => params[:doctor]).where('visit_date between ? and ?', each_day.to_datetime.beginning_of_day,each_day.to_datetime.end_of_day).length
      p @patients[each_day]
    end
    respond_to do |format|
        format.html { render partial: 'patient_report1' }
        # format.csv  { render text: patient_report_csv(@from, @to, params[:report_type])}
        # format.pdf do
        # render :pdf    => "report.pdf",
        # :disposition => "inline",
        # :layout      => 'pdf'
        # end
      end
  end

  def doctor_report
    p "---------"
    p params[:doctor]
    # @doctor = PatientDetail.find(params[:doctor])
    @patient_details = PatientDetail.where(:doctor => params[:doctor])
    render :partial => 'patient_report'
    # @patient_details = PatientDetail.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /patient_details/1/edit
  def edit
  end

  # POST /patient_details
  # POST /patient_details.json
  def create
    @patient_detail = PatientDetail.new(patient_detail_params)

    respond_to do |format|
      if @patient_detail.save
        format.html { redirect_to @patient_detail, notice: 'Patient detail was successfully created.' }
        format.json { render :show, status: :created, location: @patient_detail }
      else
        format.html { render :new }
        format.json { render json: @patient_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patient_details/1
  # PATCH/PUT /patient_details/1.json
  def update
    respond_to do |format|
      if @patient_detail.update(patient_detail_params)
        format.html { redirect_to @patient_detail, notice: 'Patient detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient_detail }
      else
        format.html { render :edit }
        format.json { render json: @patient_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_details/1
  # DELETE /patient_details/1.json
  def destroy
    @patient_detail.destroy
    respond_to do |format|
      format.html { redirect_to patient_details_url, notice: 'Patient detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_detail
      @patient_detail = PatientDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_detail_params
      params.require(:patient_detail).permit(:file_no, :name, :age, :mobile, :nationality, :payment_mode, :doctor, :visit_date)
    end
end
