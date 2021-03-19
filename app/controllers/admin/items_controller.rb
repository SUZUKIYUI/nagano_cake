class Admin::ItemsController < ApplicationController

  def index
    @items=Item.all
  end

  def new
    @item=Item.new
    @genres=Genre.all
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

end
