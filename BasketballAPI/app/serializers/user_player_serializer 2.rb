class UserPlayerSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :status
  
    attribute :game do |object|
      GameSerializer.new(object.game, {params: {current_user: @current_user}}).serializable_hash
    end
  end
  