class SessionsController < ApplicationController
  skip_before_filter :authenticate_user

  def create
    user = User.find_by_login_name(params[:login_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if params[:remember_me]
        cookies.signed[:user_id] = { :value => user.id, :expires => 2.week.from_now }
        cookies.signed[:auto_login_token] = { :value => user.auto_login_token, :expires => 2.week.from_now }
      end
      flash.notice = t("flash.sessions.create.notice")
      redirect_to :root
    else
      flash.now.alert = t("flash.sessions.create.alert")
      render :new
    end
  end
  
  def destroy
    session.delete(:user_id)
    cookies.delete(:user_id)
    cookies.delete(:auto_login_token)
    flash.notice = t("flash.sessions.destroy.notice")
    redirect_to [ :new, :session ]
  end

end
