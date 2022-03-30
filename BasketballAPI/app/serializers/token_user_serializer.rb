class TokenUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :api_key

  attribute :existed do |object, params|
    params[:existed] 
  end 

  attribute :user do |object|
    UserSerializer.new(object, {params: {current_user: object.id}}).serializable_hash
  end

end