class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items=Item.page(params[:page]).per(10)
  end

  def new
    @item=Item.new
    @genres=Genre.all
  end

  def create
    @item=Item.new(item_params)
    @genres=Genre.all

    if @item.genre_id
      @genre=Genre.find(@item.genre_id)
      @item.genre_id=@genre.id
    end

    if params[:item][:is_active] == "true"
      @item.is_active = true
    elsif params[:item][:is_active] == "false"
      @item.is_active = false
    end

    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end

  end

  def show
    @item=Item.find(params[:id])
  end

  def edit
    @item=Item.find(params[:id])
    @genres=Genre.all
  end

  def update
    @item=Item.find(params[:id])
    @genres=Genre.all

    if @item.genre_id
      @genre=Genre.find(@item.genre_id)
      @item.genre_id=@genre.id
    end

    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end

  end

# この下には何も記述しないこと！
  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price)
  end

end
