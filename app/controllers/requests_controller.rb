class RequestsController < ApplicationController

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
    @request.save!
    redirect_to "/requests"
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
  end

  private
  def request_params
    params.require(:request).permit(:title, :desc)
  end

end
