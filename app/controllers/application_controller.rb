class ApplicationController < ActionController::API
  include ActionController::Cookies

  def authenticate_cookie
    token = cookies.signed[:jwt]
    decoded_token = CoreModules::JsonWebToken.decode(token)
    user = User.find_by(id: decoded_token['user_id']) if decoded_token
    if user
      return true
    else
      render json: { status: 'unauthorized', code: 401 }
    end
  end

  def current_user
    token = cookies.signed[:jwt]
    decoded_token = CoreModules::JsonWebToken.decode(token)
    user = User.find_by(id: decoded_token['user_id']) if decoded_token
    if user
      return user
    else
      return false
    end
  end

  private

  def set_current_user
    Current.user = current_user
  end
end
