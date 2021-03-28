class Public::CartItemsController < ApplicationController

  def index
    @cart_items=CartItem.all
  end

  def update
  end

  def destroy
  end

  def empty
  end

  def create
    @cart_item=CartItem.new(cart_item_params)
    @cart_item.customer_id=current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
      render template: "public/items/show"
    end
  end

  # この下に何も記述しないこと！
  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end
