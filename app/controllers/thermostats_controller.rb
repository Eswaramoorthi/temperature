class ThermostatsController < ApplicationController
    before_action :set_thermostat, only: [:show]
    
	def show
	  render json: @thermostat.calculate_readings
	end

    private
    
    def set_thermostat
      @thermostat = Thermostat.find(params[:id])
    end
end
