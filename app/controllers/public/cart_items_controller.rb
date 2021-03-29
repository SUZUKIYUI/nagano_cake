class Public::CartItemsController < ApplicationController

  def index
    @cart_items=CartItem.all
    @cart_item=CartItem.new
  end

  def create
    @cart_item=CartItem.new(cart_item_params)
    @cart_item.customer_id=current_customer.id
    @item=Item.find(@cart_item.item_id)
    if @cart_item.save
      redirect_to cart_items_path
    else
      render template: "public/items/show"
    end
  end

  def update
    @cart_item=CartItem.find(params[:id])
    @cart_items=CartItem.all
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy
    @cart_item=CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def empty
    @cart_items=CartItem.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end


  # この下に何も記述しないこと！
  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end
