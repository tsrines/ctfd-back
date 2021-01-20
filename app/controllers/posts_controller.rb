class PostsController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :set_post, only: %i[show update destroy]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    blob =
      ActiveStorage::Blob.create_before_direct_upload!(
        io: StringIO.new((Base64.decode64(params[:image]))),
        filename: 'user.png',
        content_type: 'image/png'
      )

    puts "OUTPUT ~ file: posts_controller.rb ~ line 29 ~ filename, #{filename}"
    # file = File.open(params[:image])

    @post.save!
    @post.images.attach(blob)
    # rails_blob_path(self.cover, disposition: 'attachment', only_path: true)

    render json: { image: photo }
    #
    # render json: { imageUrl: photo }
    # puts @post.image.attached?

    # Now save that url in the post
    # render json: @post, status: :ok if @post.update(images: post.images)
  end

  # PATCH/PUT /posts/1
  def update
    byebug
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.permit(:user_id, :title, :subtitle, :content, images: [])
  end
end
