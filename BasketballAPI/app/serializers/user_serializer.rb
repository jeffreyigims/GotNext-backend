class UserSerializer 
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :firstname, :lastname, :dob, :phone

  attribute :players do |object|
    object.players.upcoming.chronological.map do |player|
      UserPlayerSerializer.new(player).serializable_hash
    end
  end

  attribute :favorites do |object, params|
    Favorite.for_favoriter(object.id).alphabetical_favoritee.map do |favorite|
      FavoriteSerializer.new(favorite, {params: {current_user: params[:current_user]}}).serializable_hash
    end
  end

  # contacts of the user who are also on the app
  attribute :potentials do |object, params|
    object.user_contacts.map do |contact|
      UsersSerializer.new(contact.user, {params: {current_user: params[:current_user]}}).serializable_hash
    end
  end

  # contacts of the user
  attribute :contacts do |object, params|
    object.contacts.not_user.map do |contact|
      ContactsSerializer.new(contact).serializable_hash 
    end
  end

  # profile picture of the user
  attribute :image do |object|
    object.get_image_url()
  end 

  # attributes :favoritees do |object|
  #   Favorite.for_favoritee(object.id).user
  # end
end
