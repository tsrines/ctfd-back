class PostsController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :set_post, only: %i[show update destroy]

  # GET /posts
  def index
    @posts = Post.all.order('created_at DESC')

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    # current_user.posts.images
    post = Post.create!(user_id: current_user.id)
    post.update(post_params)
    render json: post
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private

  def admin
    render json: { error: 'Unauthorized' } unless current_user.admin? == true
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.permit(
      :id,
      :user_id,
      :title,
      :subtitle,
      :content,
      :image,
      :image_url,
      images: []
    )
  end
end
