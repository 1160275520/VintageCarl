class RequestsController < ApplicationController
  before_action :find_request, only: [:show, :update, :edit, :destroy]

  def index
    @requests = Request.all
    @background_pic = "black"
  end

  def new
    @request = Request.new
    @background_pic = "homepic"
  end

  def create
    @request = Request.new(request_params)
    @request.userID = @current_user.id
    @request.save!
    redirect_to "/requests"
  end

  def destroy
    @request.destroy
  end

  def edit
    @background_pic = "homepic"
  end

  def update
    @request.update(request_params)
    redirect_to "/requests"
  end

  private
  def find_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :desc)
  end

end
