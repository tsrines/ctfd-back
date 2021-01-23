class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :comments

  # validates :image,
  #           attached: true,
  # content_type: %w[image/png image/jpg],
  # aspect_ratio: :landscape
end
