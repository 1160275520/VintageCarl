class ApplicationController < ActionController::Base
   before_action :logged_in
   
   def logged_in
      @logged_in = !!session[:user_id]
      @current_user = User.find(session[:user_id]) rescue nil
   end
end

