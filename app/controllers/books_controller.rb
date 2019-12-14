class BooksController < ApplicationController
  before_action :authenticate_author!, except: [:index]
  before_action :set_book, only: [:show, :edit, :update, :destroy]


  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    respond_to do |format|
      unless current_author.nil?
        @book = Book.new(book_params)
        if @book.save
          format.html { redirect_to @book, notice: 'Book was successfully created.' }
          format.json { render :show, status: :created, location: @book }
        else
          format.html { render :new }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to books_url }
        format.json { render json: "", status: 401}
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.editable_by? current_author
        if @book.update(book_params)
          format.html { redirect_to @book, notice: 'Book was successfully updated.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @book, notice: "Book cannot be edited." }
        format.json { render status: :bad_request}
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if @book.editable_by? current_author
      @book.destroy
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book cannot be deleted.' }
        format.json { render json: "Book cannot be deleted.", status: :bad_request }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author_id, :cover_image)
    end
end
