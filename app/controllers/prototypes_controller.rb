class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_in_user, only: [:edit, :update]

  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = Prototype.new(prototype_params)
    if  @prototype.save
      redirect_to root_path
    else
      render new_prototype_path
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:prototype)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if  prototype.update(prototype_params)
      redirect_to prototype
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    unless user_signed_in?
      redirect_to new_user_session_path
    end

    if current_user.id == prototype.user_id
      prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
    
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def correct_user
    @prototype = Prototype.find(params[:id])
    unless @prototype.user_id == current_user.id
      redirect_to root_path
    end
  end

  def logged_in_user
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
