class UsersSerializer 
  include FastJsonapi::ObjectSerializer
  attributes :id, :username, :email, :firstname, :lastname, :dob, :phone

  attribute :favorite do |object, params|
    if Favorite.for_users(params[:current_user], object).size >= 1
      true 
    else
      false 
    end 
  end 
end
