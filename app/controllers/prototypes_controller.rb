class PrototypesController < ApplicationController
  before_action :set_prototype,only: [:show, :edit]
  before_action :move_to_index, only: :edit
  
  def index
    @prototypes = Prototype.all 
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments = @prototype.comments
    @comment = @prototype.comments.new
  end

  def edit
  end

  def update
    prototype = Prototype.find(params[:id])
      if prototype.update(prototype_params)
        redirect_to prototype_path(prototype.id), method: :get
      else
        render :edit
      end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  
  def move_to_index 
    unless current_user.id === @prototype.user_id
      redirect_to action: :index
    end
  end
end
