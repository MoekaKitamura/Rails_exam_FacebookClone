class PicturesController < ApplicationController
  before_action :set_picture, only: %i[ show edit update destroy ]

  def index
    @pictures = Picture.all
  end

  def show
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        redirect_to @picture, notice: "Picture was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        redirect_to @picture, notice: "Picture was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      redirect_to pictures_url, notice: "Picture was successfully destroyed."
    end
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image, :content, :user_id)
  end
end
