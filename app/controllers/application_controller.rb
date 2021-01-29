class ApplicationController < ActionController::API
  include ActionController::Cookies
  def authenticate_cookie
    token = cookies.signed[:jwt]
    storage_token = request.headers['Authorization'].split(' ')[1]

    decoded_token = CoreModules::JsonWebToken.decode(storage_token)
    user = User.find_by(id: decoded_token['user_id']) if decoded_token
    if user
      return true
    else
      render json: { status: 'unauthorized', code: 401 }
    end
  end

  def current_user
    token = cookies.signed[:jwt]
    storage_token = request.headers['Authorization'].split(' ')[1]

    decoded_token = CoreModules::JsonWebToken.decode(storage_token)
    user = User.find_by(id: decoded_token['user_id']) if decoded_token
    if user
      return user
    else
      return false
    end
  end
end
