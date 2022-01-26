class PlayerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status
end
