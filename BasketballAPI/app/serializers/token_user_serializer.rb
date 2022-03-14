class TokenUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :api_key
end