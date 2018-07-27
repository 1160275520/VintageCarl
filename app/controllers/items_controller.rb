class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :update, :edit, :destroy]

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
    @item.userID = @current_user.id
    @item.save!
    redirect_to "/items/#{@item.id}"
  end

  def show
    @url = @item.image
    @background_pic = "black"
  end

  def destroy
    @item.destroy
  end

  def edit
    @background_pic = "homepic"
  end

  def update
    key = @item.title+@item.id.to_s
    path = params[:item][:image].path
    url = upload(key, path)
    @item.image = url
    @item.update(item_params)
    redirect_to @item
  end

  def search
    if params[:search]
      #sql query
      @items = Item.where("title LIKE ? OR desc LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      # optional elastic search
      # @books = Book.search(params[:search], misspellings: {edit_distance: 3} )
    else
      @items = Item.all
    end
    @background_pic = "black"
  end


  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :desc, :price)
  end

  def upload(key, path)
    obj = Bucket.object(key)
    obj.upload_file(path)
    obj.presigned_url(:get)
  end

end
