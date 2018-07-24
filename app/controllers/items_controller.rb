class ItemsController < ApplicationController

  def index
    @items = Item.all
    @background_pic = "black"
  end

  def new
    @item = Item.new
    @background_pic = "homepic"
  end

  def create
    @item = Item.new(item_params)
    key = @item.title+@item.id.to_s
    path = params[:item][:image].path
    url = upload(key, path)
    @item.sold = false
    @item.image = url
    @item.save!
    redirect_to "/items/#{@item.id}"
  end

  def show
    @item = Item.find(params[:id])
    @url = @item.image
    @background_pic = "black"
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
  end

  private
  def item_params
    params.require(:item).permit(:title, :desc, :price)
  end

  def upload(key, path)
    obj = Bucket.object(key)
    obj.upload_file(path)
    obj.presigned_url(:get)
  end

end
