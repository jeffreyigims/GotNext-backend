class UserSerializer 
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :firstname, :lastname, :dob, :phone

  attribute :dob do |object|
    object.dob.nil? ? "" : object.dob 
  end 

  attribute :phone do |object|
    object.phone.nil? ? "" : object.phone 
  end 

  attribute :games do |object, params|
    object.players.upcoming.chronological.map do |player|
      GameSerializer.new(player.game, {params: {current_user: params[:current_user]}}).serializable_hash
    end
  end

  # users who the user has favorited
  attribute :favorites do |object, params|
    Favorite.for_favoriter(object.id).alphabetical_favoritee.map do |favorite|
      UsersSerializer.new(favorite.favoritee, {params: {current_user: params[:current_user]}}).serializable_hash
    end
  end

  # users who have favorited the user 
  attribute :favoritees do |object, params|
    Favorite.for_favoritee(object.id).alphabetical_favoriter.map do |favorite|
      UsersSerializer.new(favorite.favoriter, {params: {current_user: params[:current_user]}}).serializable_hash
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
    object.contacts.alphabetical_name.not_user.map do |contact|
      ContactsSerializer.new(contact).serializable_hash 
    end
  end

  # profile picture of the user
  attribute :image do |object|
    object.get_image_url()
  end 
end
