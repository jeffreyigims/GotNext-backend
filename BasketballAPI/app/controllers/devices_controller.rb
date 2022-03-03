class DevicesController < ApplicationController

  def create
    @device = Device.new(device_params)
    if @device.save
      render json: DeviceSerializer.new(@device).serialized_json
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end


  private
  def device_params
    params.permit(:token, :platform, :user_id)
  end
end
