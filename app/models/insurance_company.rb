class InsuranceCompany < ApplicationRecord
	validates :name, presence: true
	has_many :appointments
end
