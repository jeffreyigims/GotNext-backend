class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :firstname, :lastname

  attribute :dob do |object|
    object.dob.nil? ? "" : object.dob 
  end 

  attribute :phone do |object|
    object.phone.nil? ? "" : object.phone 
  end 

  attribute :favorite do |object, params|
    fav = Favorite.for_users(params[:current_user], object).first 
    fav.nil? ? -1 : fav.id
  end

   # profile picture of the user
   attribute :image do |object|
    object.get_image_url()
  end 
end
