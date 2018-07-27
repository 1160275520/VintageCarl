class UsersController < ApplicationController
   before_action :setbackground

   def login
   end

   def stufftosell
      @books = Book.where(userID: @current_user.id)
      @items = Item.where(userID: @current_user.id)
   end

   def requests
      @requests = Request.where(userID: @current_user.id)
   end

   private
   def setbackground
      @background_pic = "black"
   end

end

