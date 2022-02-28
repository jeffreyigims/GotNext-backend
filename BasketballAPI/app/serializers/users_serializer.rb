class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :firstname, :lastname, :dob, :phone

  attribute :favorite do |object, params|
    fav = Favorite.for_users(params[:current_user], object).first 
    fav.nil? ? -1 : fav.id
  end

   # profile picture of the user
   attribute :image do |object|
    object.get_image_url()
  end 
end
