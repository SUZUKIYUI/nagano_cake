class Public::CustomersController < ApplicationController

  def show
  end

  def edit
    
  end

  def update
  end

  def leave
  end

  def withdraw
    current_customer.is_deleted = true
    if current_customer.update
      redirect_to root_path
    end
  end

end
