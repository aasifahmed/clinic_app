class CreatePatientDetails < ActiveRecord::Migration
  def change
    create_table :patient_details do |t|
      t.string :file_no
      t.string :name
      t.string :age
      t.string :mobile
      t.string :nationality
      t.string :payment_mode
      t.string :doctor
      t.datetime :visit_date

      t.timestamps null: false
    end
  end
end
