class Public::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end
  # -------------------------------------------------------------------------------------------------------
  def check
    @order = Order.new
    @cart_items = CartItem.all

    # --------------------------------total_price------------------------------------
    item_total_price = 0
    @cart_items.each do |cart_item|
      item_total_price += (cart_item.item.price + cart_item.item.price*0.1).floor * cart_item.amount
    end
    @order.total_price = item_total_price + @order.shipping_fee

    # -------------method_of_payment-----------------
    if params[:order][:method_of_payment] == "credit"
      @order.method_of_payment = 0
    elsif params[:order][:method_of_payment] == "bank"
      @order.method_of_payment = 1
    end

    # --------------delivery_postal_code/delivery_address/delivery_addressee--------------
    if params[:order][:address_select] == "my_address"
       # 『ご自身の住所』が選択された場合
      @order.delivery_address = current_customer.address
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_addressee = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_select] == "other_address"
      # 『登録済住所から選択』が選択された場合
      @address = Address.find(params[:order][:address_id])
      @order.delivery_address = @address.address
      @order.delivery_postal_code = @address.postal_code
      @order.delivery_addressee = @address.name
    elsif params[:order][:address_select] == "new_address"
      # 『新しいお届け先』が選択された場合
      @order = Order.new(order_params_check)
    end

  end
  # ---------------------------------------------------------------------------------------------------------

  def create
    @order=Order.new(order_params_create)

    if params[:order][:method_of_payment] == "0"
      @order.method_of_payment = 0
    elsif params[:order][:method_of_payment] == "1"
      @order.method_of_payment = 1
    end

    @order.customer_id = current_customer.id

    if @order.save
      @order_item = OrderItem.new
      @order_item.order_id = @order.id
      current_customer.cart_items.each do |cart_item|
        @order_item.item_id = cart_item.item.id
        @order_item.tax_included_price = (cart_item.item.price + cart_item.item.price*0.1).floor
        @order_item.amount = cart_item.amount
        @order_item.save
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render :check
    end
  end

  def thanks
  end

  def show
    @order = Order.find(params[:id])
  end

  # この下に何も記述しないこと！
  private

  def order_params_check
    params.require(:order).permit(:delivery_postal_code,:delivery_address, :delivery_addressee)
  end

  def order_params_create
    params.require(:order).permit(:customer_id, :total_price, :delivery_postal_code, :delivery_address, :delivery_addressee)
  end

end
