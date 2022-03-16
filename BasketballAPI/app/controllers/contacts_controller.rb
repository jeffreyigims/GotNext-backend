class ContactsController < ApplicationController

    # before_action :set_favorite, only: [:show, :destroy]

    def contacts 
        @data = params[:data]
        @user = params[:user]
        @data.map { |contact| 
            u = contact["user"]
            @contact = Contact.new(:firstName => u["firstName"], :lastName => u["lastName"], :phone => u["phone"], :user_id => @user).save
        }
        render json: UserSerializer.new(@current_user, {params: {current_user: @current_user}}).serialized_json
    end 
  
    def index
      @favorites = Favorite.alphabetical_favoriter
      render json: FavoriteSerializer.new(@favorites).serialized_json
    end
  
    def show
      render json: FavoriteSerializer.new(@favorite).serialized_json
    end
  
    def create
      @favorite = Favorite.new(favorite_params)
      if @favorite.save
        render json: FavoriteSerializer.new(@favorite).serialized_json
      else
        render json: @favorite.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @favorite.destroy
      if !@favorite.destroyed?
        render json: @favorite.errors, status: :unprocessable_entity
      else
        render json: FavoriteSerializer.new(@favorite).serialized_json
      end
    end
  
    private
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end
  
    def contact_params
      params.permit(:firstName, :lastName, :phone, :user_id)
    end
  
  end