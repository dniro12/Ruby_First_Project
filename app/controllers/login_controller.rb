class LoginController < ApplicationController
  
  def index
    render :action => 'login'
  end 
   
  def login
    
  end
  
  def do_login
    username = params[:username]
    password = params[:password]
    
    if username.nil? || password.nil? || username == password
      redirect_to :action => 'login'
      flash[:notice] =  "UnKnown User or Invalid password"
    else
      session["user_id"] = username
      redirect_to :controller => "posts", :action => "index"
    end
  end

end
