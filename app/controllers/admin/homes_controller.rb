class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders=Order.all
    @one_person_orders=Order.find_by(customer_id: params[:id])
  end

end

