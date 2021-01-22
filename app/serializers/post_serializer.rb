class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user, :comments, :created_at
end
