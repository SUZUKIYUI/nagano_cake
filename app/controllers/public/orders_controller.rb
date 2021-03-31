class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def check
    @order = Order.new
    if params[:order][:address_select] == "my_address"
      @order.delivery_address = current_customer.address
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_addressee = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_select] == "other_address"
      # address.find
      @address = Address.find(params[:address_select])
      @order.delivery_address = @address.address
      @order.delivery_postal_code = @address.postal_code
      @order.delivery_addressee = @address.name
    elsif params[:order][:address_select] == "new_address"
      # address.save
      @order = Order.new(order_params)
      if @order.save == false
        render :new
      end
    end
  end

  def thanks
  end

  def create
  end

  def index
  end

  def show
  end

  # この下に何も記述しないこと！
  private

  def order_params
    params.require(:order).permit(:delivery_postal_code,:delivery_address, :delivery_addressee)
  end

end
