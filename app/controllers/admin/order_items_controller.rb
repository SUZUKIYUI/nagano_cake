class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(order_item_params)
    @order = Order.find(@order_item.order_id)
    @order_items = OrderItem.where(order_id: @order.id)

    if @order_item.production_status == "in_production"
      @order.order_status = "in_production"
      @order.save
      redirect_to admin_order_path(@order_item.order_id)
    elsif @order_items.count == @order_item.order.order_items.where(production_status: "production_completed").count
      @order.update(order_status: "preparing_to_ship")
      redirect_to admin_order_path(@order_item.order_id)
    end
  end

# この下に何も記述しないこと！
  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

end
