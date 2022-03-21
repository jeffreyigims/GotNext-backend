class DeviceSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :token, :platform 
end
  