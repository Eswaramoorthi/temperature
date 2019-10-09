class Reading < ApplicationRecord

  belongs_to :thermostat
  validates :thermostat_id, :temperature, :humidity, :battery_charge, presence: true  
end
