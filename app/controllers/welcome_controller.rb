class WelcomeController <ApplicationController
   def index
      puts session[:user_id]
      @background_pic = "homepic"
   end
end

