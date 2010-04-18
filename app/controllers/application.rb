# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :set_user 

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c98a1fac4b9ef949d770e99d25bd9e24'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  protected
     def set_user
       @user = User.find(session[:id]) if @user.nil? && session[:id]
     end

     def login_required
       return true if @user
       access_denied
       return false
     end

     def access_denied
       session[:return_to] = request.request_uri
       flash[:error] = 'Oops. You need to login before you can view that page.'
       redirect_to :controller => 'user', :action => 'login'
     end
end
