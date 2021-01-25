class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  enum role: %i[user admin]
  devise :database_authenticatable, :validatable

  def self.handle_login(userObject)
    user_info = Hash.new
    user_info[:token] =
      CoreModules::JsonWebToken.encode(
        { user_id: userObject.id },
        4.hours.from_now
      )
    user_info[:user_id] = userObject.id
    user_info[:user] = userObject
    user_info[:name] = userObject.name
    return user_info
  end

  def self.handle_register(profile)
    new_user =
      User.create!(
        uid: profile['id'],
        email: profile['email'],
        name: profile['name'],
        avatar: profile['picture']['data']['url'],
        password: SecureRandom.uuid
      )

    user_info = Hash.new
    user_info[:token] =
      CoreModules::JsonWebToken.encode(
        { user_id: new_user.id },
        4.hours.from_now
      )
    new_user.update(token: user_info[:token])
    user_info[:user_id] = new_user.id
    user_info[:user] = new_user
    user_info[:name] = new_user.name
    return user_info
  end
end
