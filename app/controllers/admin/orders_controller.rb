class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order=Order.find(params[:id])
  end

  def update
    @order=Order.find(params[:id])
    @order.update(order_params)
    @order_items=OrderItem.where(order_id: @order.id)

    if @order.order_status == "payment_confirmation"
      @order_items.each do |order_item|
        order_item.production_status = "waiting_for_production"
        order_item.save
      end
      redirect_to admin_order_path(@order.id)
    elsif @order.order_status == "waiting_for_payment"
      @order_items.each do |order_item|
        order_item.production_status = "not_startable"
        order_item.save
      end
      redirect_to admin_order_path(@order.id)
    else
      redirect_to admin_order_path(@order.id)
    end
  end

# この下に何も記述しないこと！
  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
