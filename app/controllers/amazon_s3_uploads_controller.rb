class AmazonS3UploadsController < ApplicationController
  require 'aws-sdk-s3'

  def set_s3_direct_post
    filename = params[:filename]
    file_type = params[:fileType]
    directory = params[:directory]
    random_path = SecureRandom.uuid
    key = "uploads/#{directory}/#{random_path}/#{filename}"

    signer = Aws::S3::Presigner.new
    post_url =
      signer.presigned_url(
        :put_object,
        bucket: 'ctfd-code-challenge',
        key: key,
        acl: 'public-read',
        content_type: file_type
      )

    get_url = "https://ctfd-code-challenge.s3-us-east-2.amazonaws.com/#{key}"
    json_response({ post_url: post_url, get_url: get_url })
  end

  def attach_image_url
    post = Post.new(user_id: Current.user.id, content: 'first post!')
  end

  private

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
