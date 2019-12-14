class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update]

  def index
    @authors = Author.all
  end

  def show
  end

  def edit
    if current_author.id == @author.id
      render :edit
    else
      redirect_to authors_url
    end
  end

  def update
    respond_to do |format|
      if current_author.id == @author.id && @author.update(author_params) 
        format.html { redirect_to @author, notice: "Your information was updated." }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unpocessable_entity }
      end
    end
  end

  private

    def set_author 
      @author = Author.find params[:id]
    end

    def author_params
      params.require(:author).permit(:name, :email)
    end

end
