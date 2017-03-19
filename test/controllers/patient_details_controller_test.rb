require 'test_helper'

class PatientDetailsControllerTest < ActionController::TestCase
  setup do
    @patient_detail = patient_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:patient_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create patient_detail" do
    assert_difference('PatientDetail.count') do
      post :create, patient_detail: { age: @patient_detail.age, doctor: @patient_detail.doctor, file_no: @patient_detail.file_no, mobile: @patient_detail.mobile, name: @patient_detail.name, nationality: @patient_detail.nationality, payment_mode: @patient_detail.payment_mode, visit_date: @patient_detail.visit_date }
    end

    assert_redirected_to patient_detail_path(assigns(:patient_detail))
  end

  test "should show patient_detail" do
    get :show, id: @patient_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @patient_detail
    assert_response :success
  end

  test "should update patient_detail" do
    patch :update, id: @patient_detail, patient_detail: { age: @patient_detail.age, doctor: @patient_detail.doctor, file_no: @patient_detail.file_no, mobile: @patient_detail.mobile, name: @patient_detail.name, nationality: @patient_detail.nationality, payment_mode: @patient_detail.payment_mode, visit_date: @patient_detail.visit_date }
    assert_redirected_to patient_detail_path(assigns(:patient_detail))
  end

  test "should destroy patient_detail" do
    assert_difference('PatientDetail.count', -1) do
      delete :destroy, id: @patient_detail
    end

    assert_redirected_to patient_details_path
  end
end
