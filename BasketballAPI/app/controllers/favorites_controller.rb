class FavoritesController < ApplicationController

  before_action :set_favorite, only: [:show, :destroy]

  def index
    @favorites = Favorite.all
    render json: @favorites
  end

  def show
    render json: @favorite
  end

  def create
    @favorite = Favorite.new(favorite_params)
    if @favorite.save
      render json: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite.destroy
    if !@favorite.destroyed?
      render json: @favorite.errors, status: :unprocessable_entity
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