class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :is_published
  has_many :comments
  belongs_to :user
end
