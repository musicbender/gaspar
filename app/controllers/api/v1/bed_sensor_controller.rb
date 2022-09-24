
class Api::V1::BedSensorController < ApplicationController
  def index
    render json: { message: 'huzzahhh'}
  end
end