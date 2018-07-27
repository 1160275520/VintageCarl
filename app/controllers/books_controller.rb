class BooksController < ApplicationController
  before_action :find_book, only: [:show, :update, :edit, :destroy]

  def index
    @books = Book.all
    @background_pic = "black"
  end

  def new
    @book = Book.new
    @background_pic = "homepic"
  end

  def create
    @book = Book.new(book_params)
    key = @book.title+@book.id.to_s
    path = params[:book][:image].path
    url = upload(key, path)
    @book.sold = false
    @book.image = url
    @book.userID = @current_user.id
    @book.save!
    redirect_to "/books/#{@book.id}"
  end

  def show
    @url = @book.image
    @background_pic = "black"
  end

  def destroy
    @book.destroy
  end

  def edit
    @background_pic = "homepic"
  end

  def update
    key = @book.title+@book.id.to_s
    path = params[:book][:image].path
    url = upload(key, path)
    @book.image = url
    @book.update(book_params)
    redirect_to @book
  end

  def search
    if params[:search]
      # sql query
      @books = Book.where("title LIKE ? OR author LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      # optional elastic search
      # @books = Book.search(params[:search], misspellings: {edit_distance: 3} )
    else
      @books = Book.all
    end
    @background_pic = "black"
  end

  private
  def find_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :courses, :price)
  end

  def upload(key, path)
    obj = Bucket.object(key)
    obj.upload_file(path)
    obj.presigned_url(:get)
  end

  def delete(key)
    obj = Bucket.object(key)
    obj.delete
  end

end
