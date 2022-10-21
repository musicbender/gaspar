
class Api::V1::BedSensorController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def index
    bed_sensors = BedSensor.all
    render json: { bed_sensor: bed_sensors } 
  end

  def show 
    render json: { bed_sensor: bed_sensor } 
  end
 
  def update
    if bed_sensor
      bed_sensor.update(bed_sensor_update_params)
      render json: { bed_sensor: bed_sensor}
    else
      render json: { errors: bed_sensor.errors }, status: 500
    end
  end

  def create
    new_bed_sensor = BedSensor.new(bed_sensor_params)

    if new_bed_sensor.save
      render json: { bed_sensor: new_bed_sensor }
    else
      render json: { errors: new_bed_sensor.errors }, status: 500
    end
  end

  private
    def bed_sensor_params
      params.require(:bed_sensor).permit(:name, :is_active)
    end

    def bed_sensor_update_params
      params.require(:bed_sensor).permit(:is_active)
    end

    def bed_sensor
      @bed_sensor ||= BedSensor.find_by!(id: id)
    end

    def id
      params.require(:id)
    end

    def record_not_found
      render json: { errors: ["Couldn't find BedSensor {id: #{id}}"] }, status: 500
    end
end