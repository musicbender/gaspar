
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
      request_webhook(params[:is_active])
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

    def other_bed_sensor(id)
      @other_bed_sensor ||= BedSensor.find_by!(id: id)
    end

    def id
      params.require(:id)
    end

    def request_webhook(is_active) 
      hb_webook_service = HbWebhookService.new
      other_id = id.to_i == 1 ? 2 : 1;
      switch_state = nil

      if is_active == other_bed_sensor(other_id)&.is_active
        switch_state = is_active
      end

      unless switch_state.nil?
        hb_webook_service.set_nighty_night(switch_state)
      end
    end

    def record_not_found
      render json: { errors: ["Couldn't find BedSensor {id: #{id}}"] }, status: 500
    end
end