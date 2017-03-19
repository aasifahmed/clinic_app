class Appointment < ApplicationRecord
  belongs_to :insurance_company #, optional: true
  belongs_to :doctor

  scope :age, -> (age) { where age: age }
  scope :sex, -> (sex) { where sex: sex }
  scope :nationality, -> (nationality) { where nationality: nationality }
  scope :file_no, -> (file_no) { where file_no: file_no }
  scope :patient_name, -> (patient_name) { where("patient_name like ?", "%patient_name%") }
  scope :visit_type, -> (visit_type) { where visit_type: visit_type }
  scope :cash, -> (cash) { where cash: cash }
  scope :by_doctor, -> (doctor_id) { where doctor_id: doctor_id }
  scope :appointment_time_between, -> (min_time, max_time) { where(appointment_time: min_time..max_time)}
end
