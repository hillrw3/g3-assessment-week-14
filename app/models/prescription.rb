class Prescription < ActiveRecord::Base

  validates :patient_id, :medication_id, :dosage, :schedule, :starts_on, :ends_on, presence: true
  validate :start_date_before_end_date

  belongs_to :patient
  belongs_to :medication

  def start_date_before_end_date
    if starts_on > ends_on
      errors.add(:ends_on, " must be after the start date")
    end
  end
end