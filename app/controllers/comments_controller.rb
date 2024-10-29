class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)
    @prototype = Prototype.find(params[:prototype_id])
    @comments = @prototype.comments.includes(:user)

    if @comment.save
      redirect_to @prototype, notice: "コメントを投稿しました。"
    else
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(prototype_id: params[:prototype_id])
  end
end