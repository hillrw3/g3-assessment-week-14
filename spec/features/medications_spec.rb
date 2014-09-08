require 'rails_helper'
require 'capybara/rails'

feature "Medications" do

  def create_user
    User.create!(
      name: "Some User",
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  def create_patient
    Patient.create!(first_name: "Will", last_name: "Schuster")
  end

  scenario "user can click on a medication on index and see all patients on that medicine" do
    Medication.create!(name: "Tylenol")
    user = create_user
    patient = create_patient
    login(user)
    expect(page).to have_content "Dashboard"
    Prescription.create!(patient_id: Patient.find_by(first_name: "Will").id,
                         medication_id: Medication.find_by(name: "Tylenol").id,
                         dosage: "3 pills",
                         schedule: "once a day",
                         starts_on: Date.today,
                         ends_on: Date.today + 2
    )
    click_on "Tylenol"
    expect(page).to have_content "Will Schuster"

  end
end