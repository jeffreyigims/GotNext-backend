class TokenUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :api_key

  attribute :existed do |object, params|
    params[:existed] 
  end 

  attribute :user do |object|
    UserSerializer.new(object, {params: {current_user: object.id}}).serializable_hash
  end

  attribute :app_link do |object|
    "https://apps.apple.com/us/app/gotnextgame/id1615780129" 
  end 

end