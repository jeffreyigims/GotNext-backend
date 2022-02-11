require 'base64'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :games]

  include Filterable
  include Orderable

  BOOLEAN_FILTERING_PARAMS = [[], []]
  PARAM_FILTERING_PARAMS = []
  ORDERING_PARAMS = [:alphabetical_username, :alphabetical_name]

  def index
    @users = boolean_filter(User.all, BOOLEAN_FILTERING_PARAMS)
    @users = param_filter(@users, PARAM_FILTERING_PARAMS)
    @users = order(@users, ORDERING_PARAMS)
    render json: UsersSerializer.new(@users, {params: {current_user: @current_user}}).serialized_json
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user, {params: {current_user: @current_user}}).serialized_json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: UserSerializer.new(@user, {params: {current_user: @current_user}}).serialized_json
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user, {params: {current_user: @current_user}}).serialized_json
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    if !@user.destroyed?
      render json: @user.errors, status: :unprocessable_entity
    else
      render json: UserSerializer.new(@user, {params: {current_user: @current_user}}).serialized_json
    end
  end

  def games
    @games = @user.games
    render json: GamesSerializer.new(@games).serialized_json
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit({image: :data}, :id, :firstname, :lastname, :email, :username, :dob, :phone, :image, :password, :password_confirmation)
  end
end
