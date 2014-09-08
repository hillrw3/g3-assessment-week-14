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

  scenario "user can click on patient and see table for prescriptions" do
    user = create_user
    patient = create_patient
    login(user)
    expect(page).to have_content "Dashboard"
    click_on "Will Schuster"
    expect(page).to have_content "Prescriptions"
  end

end