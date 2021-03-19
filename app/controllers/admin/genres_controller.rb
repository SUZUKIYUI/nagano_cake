class Admin::GenresController < ApplicationController

  def index
    @genre=Genre.new
    @genres=Genre.all
  end

  def create
  end

  def edit
    @genre=Genre.find(params[:id])
  end

  def update
  end

end
