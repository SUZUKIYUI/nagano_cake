class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders = Order.all.page(params[:page]).per(10)
    if params[:id]
      @customer = Customer.find(params[:id])
      @one_person_orders = Order.where(customer_id: @customer.id).page(params[:page]).per(10)
    end
  end

end

