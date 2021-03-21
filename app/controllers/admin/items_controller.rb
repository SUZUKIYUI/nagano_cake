class Admin::ItemsController < ApplicationController

  def index
    @items=Item.all
  end

  def new
    @item=Item.new
    @genres=Genre.all
  end

  def create
    @item=Item.new(item_params)
    @genre=Genre.find_by(name: genre_params)
    @item.genre_id=@genre.id
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
    @genre=@item.genre
  end

  def update
    @item=Item.find(params[:id])
    @genre=Genre.find_by(name: genre_params)
    @item.genre_id=@genre.id
    if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

# この下には何も記述しないこと！
  private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :is_active)
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
