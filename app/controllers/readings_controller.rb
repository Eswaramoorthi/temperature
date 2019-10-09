class ReadingsController < ApplicationController
  before_action :set_thermostat
  before_action :set_reading, only: [:show]

  def create
      reading = @thermostat.readings.build(reading_params)
      if reading.valid?
        tracking_number = @thermostat.readings.maximum(:tracking_number).to_i+0
      
        ReadingWorker.perform_async(reading_params.to_hash.merge({thermostat_id: @thermostat.id}))
        json_response({tracking_number: tracking_number }, :accepted)
      else
        json_response(reading.errors.messages, :unprocessable_entity)
      end
  end
  
  def show
    json_response(@reading)
  end

  private

  def reading_params
    params.permit(:temperature, :humidity, :battery_charge, :thermostat_id)
  end

  def set_thermostat
    @thermostat = Thermostat.find(params[:thermostat_id])
  end

  def set_reading
    @reading = Reading.find(params[:id])
  end
end
