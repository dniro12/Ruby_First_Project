class UserController < ApplicationController
  before_filter :login_required, :only => :my_account
  
  def login
    @user = User.new
    @user.username = params[:username]
  end

  def process_login
    if user = User.authenticate(params[:user])
      session[:id] = user.id
      redirect_to :controller => 'posts'
      logger.debug "Login Success"
    else
      flash[:error] = 'Invalid login.'
      redirect_to :action => 'login', :username => params[:user][:username]
      logger.debug "Login Failed"
    end
  end

  def logout
    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :action => 'login'
  end

  def my_account
  end

end
