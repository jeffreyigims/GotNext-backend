class GameSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :date, :time, :description, :private, :longitude, :latitude, :shortAddress, :longAddress

  attribute :invited do |object, params|
    object.players.invited.alphabetical.map do |player|
      UsersSerializer.new(player.user, {params: {current_user: params[:current_user]}}).serializable_hash
    end
  end

  attribute :maybe do |object, params|
    object.players.maybe.alphabetical.map do |player|
      UsersSerializer.new(player.user, {params: {current_user: params[:current_user]}}).serializable_hash
    end
  end

  attribute :going do |object, params|
    object.players.going.alphabetical.map do |player|
      UsersSerializer.new(player.user, {params: {current_user: params[:current_user]}}).serializable_hash
    end
  end

  attribute :player do |object, params|
    player = object.players.for_user(params[:current_user]).first
    player.nil? ? player : PlayerSerializer.new(player).serializable_hash
  end
end
