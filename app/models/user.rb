class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  enum role: %i[user admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable

  def self.handle_login(email, uid)
    user = User.find_or_create_by(uid: uid)
    if user && user.uid == uid
      user_info = Hash.new
      user_info[:token] =
        CoreModules::JsonWebToken.encode({ user_id: user.id }, 4.hours.from_now)
      user_info[:user_id] = user.id
      user_info[:user] = user
      return user_info
    else
      return false
    end
  end
end
