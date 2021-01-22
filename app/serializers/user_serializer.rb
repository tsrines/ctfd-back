class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :avatar, :role
  has_many :posts
  has_many :comments
end
