class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order=Order.find(params[:id])
  end

  def update
    @order=Order.find(params[:id])

    if params[:order][:order_status] == "0"
      @order.order_status = 0
    elsif params[:order][:order_status] == "1"
      @order.order_status = 1
    elsif params[:order][:order_status] == "2"
      @oeder.order_status = 2
    elsif params[:order][:order_status] == "3"
      @order.order_status = 3
    elsif params[:order][:order_status] == "4"
      @order.order_status = 4
    end

    if @order.update
      redirect_to admin_order_path(@order.id)
    end
  end

end
