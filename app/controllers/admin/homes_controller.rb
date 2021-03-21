class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @orders=Order.all
    if params[:id]
      @one_person_orders=Order.find_by(customer_id: params[:id])
    end
  end

end

