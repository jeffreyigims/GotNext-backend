class UserSerializer 
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :firstname, :lastname, :dob, :phone

  attribute :players do |object|
    object.players.upcoming.chronological.map do |player|
      PlayerSerializer.new(player).serializable_hash
    end
  end

  attribute :favorites do |object, params|
    Favorite.for_favoriter(object.id).map do |favorite|
      FavoriteSerializer.new(favorite, {params: {current_user: params[:current_user]}}).serializable_hash
    end
  end

  attribute :potentials do |object, params|
    object.user_contacts.map do |contact|
      UsersSerializer.new(contact.user, {params: {current_user: params[:current_user]}}).serializable_hash
    end
  end

  attribute :contacts do |object, params|
    object.contacts.not_user.map do |contact|
      ContactsSerializer.new(contact).serializable_hash 
    end
  end

  # attributes :favoritees do |object|
  #   Favorite.for_favoritee(object.id).user
  # end
end
