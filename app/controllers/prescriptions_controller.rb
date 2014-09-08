class PrescriptionsController < ApplicationController

  def new
    @patient = Patient.find(params[:patient_id])
    @prescription = Prescription.new
  end

  def create
    starts_on = "#{params[:prescription]['starts_on(1i)']}/#{params[:prescription]['starts_on(2i)']}/#{params[:prescription]['starts_on(3i)']}"
    ends_on = "#{params[:prescription]['ends_on(1i)']}/#{params[:prescription]['ends_on(2i)']}/#{params[:prescription]['ends_on(3i)']}"
    @prescription = Prescription.new(patient_id: params[:prescription][:patient_id],
                     medication_id: params[:prescription][:medication],
                     dosage: params[:prescription][:dosage],
                     schedule: params[:prescription][:schedule],
                     starts_on: starts_on,
                     ends_on: ends_on
    )
    @patient = Patient.find(params[:prescription][:patient_id])
    if @prescription.save
      flash[:notice] = "Your prescription has been created"
      redirect_to patient_path(id: @patient.id)
    else
      render :new
    end
  end
end