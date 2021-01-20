class SessionsController < ApplicationController
  before_action only: %i[destroy] do
    authenticate_cookie
  end

  def destroy
    user = current_user
    if user
      cookies.delete(:jwt)
      render json: { status: 'OK', code: 200 }
    else
      render json: { status: 'session not found', code: 404 }
    end
  end

  def create
    graph = Koala::Facebook::API.new(params[:accessToken])
    profile = graph.get_object('me', fields: 'id, email, name, picture')
    email = profile['email']
    uid = profile['id']

    if email && uid
      login_hash = User.handle_login(email, uid)
      if login_hash
        cookies.signed[:jwt] = { value: login_hash[:token], httponly: true }
        # render json: { user_id: login_hash[:user_id], name: login_hash[:name] }
        render json: login_hash[:user]
      else
        render json: { status: 'Log back into facebook', code: 422 }
      end
    else
      render json: { status: 'Log back into facebook', code: 422 }
    end
  end

  def not_found
    render json: { message: 'Sorry, that page no longer exists' }
  end
end
