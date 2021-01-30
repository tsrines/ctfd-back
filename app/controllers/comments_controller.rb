class CommentsController < ApplicationController
  def create
    @comment =
      Comment.new(
        post_id: params[:post_id],
        user_id: current_user.id,
        content: params[:content],
        author_avatar: user.avatar,
        author_email: user.email,
        author_name: user.name
      )

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.permit(:user_id, :post_id, :content, :user, :post)
  end
end
