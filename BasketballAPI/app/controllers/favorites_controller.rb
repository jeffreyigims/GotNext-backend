class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :destroy]

  include PushService

  def index
    @favorites = Favorite.alphabetical_favoriter
    render json: FavoriteSerializer.new(@favorites, {params: {current_user: @current_user}}).serialized_json
  end

  def show
    render json: FavoriteSerializer.new(@favorite, {params: {current_user: @current_user}}).serialized_json
  end

  def create
    @favorite = Favorite.new(favorite_params)
    send_push_favorite(favorite_params[:favoriter_id], favorite_params[:favoritee_id])
    if @favorite.save
      render json: FavoriteSerializer.new(@favorite, {params: {current_user: @current_user}}).serialized_json
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite.destroy
    if !@favorite.destroyed?
      render json: @favorite.errors, status: :unprocessable_entity
    else
      render json: FavoriteSerializer.new(@favorite, {params: {current_user: @current_user}}).serialized_json
    end
  end

  private
  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def favorite_params
    params.permit(:favoriter_id, :favoritee_id)
  end

end