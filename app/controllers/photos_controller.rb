class PhotosController < ApplicationController
  before_action :find_photo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @photos = Photo.all.order('created_at DESC')
  end

  def show

  end

  def new
    @photo = current_user.photos.build
  end

  def create
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      flash[:success] = "Photo has been posted!"
      redirect_to @photo
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @photo.update(photo_params)
      flash[:success] = "Photo successfully updated."
      redirect_to @photo
    else
      render 'edit'
    end
  end

  def destroy
    @photo.destroy
    redirect_to root_path
  end


  private

  def photo_params
    params.require(:photo).permit(:title, :description, :image)
  end

  def find_photo
    @photo = Photo.find(params[:id])
  end

  def require_same_user
    if current_user != @photo.user
      flash[:danger] = 'You can only edit or delete your own photos.'
      redirect_to root_path
    end
  end

end
