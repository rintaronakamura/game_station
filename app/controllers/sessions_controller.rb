class SessionsController < ApplicationController
  skip_before_action :logged_in_required, only: :create
  skip_after_action :verify_authorized


  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    log_in user.id
    redirect_to_or_back(user, notice: 'ログインしました。')
  end

  def destroy
    log_out
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
