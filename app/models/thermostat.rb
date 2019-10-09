class Thermostat < ApplicationRecord

  has_many :readings, dependent: :destroy
  validates :household_token, :location, presence: true


  def calculate_readings
    columns = [:temperature, :humidity, :battery_charge]
    data = self.readings
    answer = {
      temperature: {average: nil, minimum: nil, maximum: nil}, 
      humidity: {average: nil, minimum: nil, maximum: nil},
      battery_charge: {average: nil, minimum: nil, maximum: nil},
    }
    if data.size > 0 then
      columns.each do |colum|
        arr = data.map(&colum)
        answer[colum][:average] = arr.sum / arr.size.to_f
        answer[colum][:minimum] = arr.min
        answer[colum][:maximum] = arr.max
      end
    end
    return answer
  end
end
