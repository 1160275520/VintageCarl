class BooksController < ApplicationController

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
    @book.save!
    redirect_to "/books/#{@book.id}"
  end

  def show
    @book = Book.find(params[:id])
    @url = @book.image
    @background_pic = "black"
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :courses, :price)
  end

  def upload(key, path)
    obj = Bucket.object(key)
    obj.upload_file(path)
    obj.presigned_url(:get)
  end

end
