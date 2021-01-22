class PostSerializer < ActiveModel::Serializer
  attributes :id,
             :content,
             :user.as_json(only: %i[name email avatar]),
             :comments,
             :created_at
end
