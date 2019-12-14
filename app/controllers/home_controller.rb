class HomeController < ApplicationController
  def index
    @authors = Author.all
  end
end
