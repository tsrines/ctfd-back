class Post < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  has_many_attached :images, dependent: :destroy
  has_many :comments
  has_one_attached :markdown, dependent: :destroy
  # validates :image,
  #           attached: true,
  # content_type: %w[image/png image/jpg],
  # aspect_ratio: :landscape
end
