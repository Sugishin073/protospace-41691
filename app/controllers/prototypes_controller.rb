class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:new, :edit, :destroy]
  before_action :move_to_index, only: [:edit]
  def index
    @prototypes = Prototype.includes(:user).all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: 'プロトタイプを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
  if@prototype.destroy
    redirect_to root_path, notice: "プロトタイプを削除しました。"
  else
    redirect_to prototype_path(@prototype), alert: "プロトタイプの削除に失敗しました。"
  end
  end


  private

  # ストロングパラメーターを定義
  def prototype_params
    params.require(:prototype).permit(:title, :description,:catch_copy, :concept,:image).merge(user_id: current_user.id)
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])
    if current_user != @prototype.user
      redirect_to action: :index
    end
  end
end
