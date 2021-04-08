class FavoriteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :favoriter_id, :favoritee_id

  attribute :user do |object, params|
    UsersSerializer.new(object.favoritee, {params: {current_user: params[:current_user]}}).serializable_hash
  end
  
end
