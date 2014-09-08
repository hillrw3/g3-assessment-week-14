require 'rails_helper'
require 'capybara/rails'

feature "Patients" do
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

  scenario "User sees all patients" do
    user = create_user
    patient = create_patient
    login(user)

    expect(page).to have_content(patient.first_name, patient.last_name)
  end

  scenario "user can click on patient to see table for prescriptions and add prescription" do
    user = create_user
    patient = create_patient
    login(user)
    expect(page).to have_content "Dashboard"
    click_on "Will Schuster"
    expect(page).to have_content "Prescriptions"
    click_on "Add Prescription"
    expect(page).to have_content "Add a prescription for Will Schuster"
    select "Tylenol", from: "Medication"
    fill_in "Dosage", with: "2 pills"
    fill_in "Schedule", with: "Once a day"
  end


end