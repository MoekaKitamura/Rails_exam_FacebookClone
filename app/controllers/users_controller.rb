class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :login_required, only: [:new, :create]
  # before_action :already_logged_in?, only: [:new, :create]
  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to new_user_path, notice: "User was successfully destroyed."
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
