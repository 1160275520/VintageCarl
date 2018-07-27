class SessionsController < ApplicationController
   def create
      reset_session
      @user = User.find_or_create_by(uid: params[:uid], provider: params[:provider], url: params[:url])
      session[:user_id] = @user.id
      redirect_to root_path
   end

   def destroy
      reset_session
      render json: {staus: "loggedout"}, status: "ok"
   end
end