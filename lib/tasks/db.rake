 namespace :db do
     task :backup do
     system "mysqldump --opt --user=root --password=admin clinic_app > dbs/store_#{Time.now.strftime('%Y%m%d%H%M%S')}.sql"
  end


  task :restore do
 #    system "mysqldump --user=root --password=admin  < store_backup.sql"
   end

  task :clean do
	Dir.foreach('/dbs') {|f| File.delete(f) if f != '.' && f != '..'}
   end
   
  desc "load user data from csv"
  task :load_csv_task  => :environment do
	require 'csv'
			CSV.foreach("public/patient.csv", headers: true) do |row|
			 c = PatientDetail.new
			 c.file_no = row[1]
			 c.name = row[2]
			 c.age = row[3]
			 c.mobile = row[4]
			 c.nationality = row[5]
			 c.payment_mode = row[6]
			 c.doctor = row[7]
			 c.visit_date = row[8].to_datetime
			 if c.save
				 p c.name + " Saved"
			 else
				 p c.name + " not Saved"
			 end
			end
   end

  end