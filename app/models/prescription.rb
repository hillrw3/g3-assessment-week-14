class Prescription < ActiveRecord::Base

  validates :patient_id, :medication_id, :dosage, :schedule, :starts_on, :ends_on, presence: true

  belongs_to :patient
  belongs_to :medication
end