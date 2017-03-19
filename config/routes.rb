Rails.application.routes.draw do
# get 'patient_details/report' => 'patient_details#report'
# get '/patient_report' => 'patient_details#patient_report'
# get '/doctor_report' => 'patient_details#doctor_report'
# get '/all_reports' => 'patient_details#all_reports'
# get 'patient_details/doctor' => 'patient_details#doctor'
#   get '/doctors_name' => 'patient_details#doctors_name'
#   get '/payment_type' => 'patient_details#payment_type'
#   get '/nationality_name' => 'patient_details#nationality_name'
# match '/patient_details/all_report' => 'patient_details#all_report', :via => [:get, :post]
# get 'dashboard' => 'patient_details#dashboard'
# get 'chart' => 'patient_details#chart'
#   resources :patient_details
# root :to => 'patient_details#dashboard'
get '/search' => 'appointments#search'
  post '/search_result' => 'appointments#search_result'
  resources :appointments
  resources :insurance_companies
  resources :doctors
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   root :to => 'appointments#search'  
end
