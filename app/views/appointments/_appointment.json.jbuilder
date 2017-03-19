json.extract! appointment, :id, :file_no, :patient_name, :appointment_time, :age, :sex, :nationality, :visit_type, :cash, :insurance_company_id, :doctor_id, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
