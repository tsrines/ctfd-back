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
    user = User.find_by(uid: profile['id'])

    if user
      login_hash = User.handle_login(user)

      if login_hash
        cookies.signed[:jwt] = { value: login_hash[:token], httponly: true } # render json: { user_id: login_hash[:user_id], name: login_hash[:name] }
        user.update(token: login_hash[:token])
        render json: {
                 user_id: login_hash[:user_id],
                 name: login_hash[:name],
                 user: login_hash[:user]
               }
      else
        render json: { status: 'Log back into facebook', code: 422 }
      end
    else
      login_hash = User.handle_register(profile)
      if login_hash
        cookies.signed[:jwt] = { value: login_hash[:token], httponly: true }
        render json: {
                 user_id: login_hash[:user_id],
                 name: login_hash[:name],
                 user: login_hash[:user]
               }
      else
        render json: { status: 'Log back into facebook', code: 422 }
      end
    end
  end
end
