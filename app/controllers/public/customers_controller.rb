class Public::CustomersController < ApplicationController

  def show
  end

  def edit
  end

  def update
    if current_customer.update(current_customer_params)
      redirect_to current_customer_path
    else
      render :edit
    end
  end

  def leave
  end

  def withdraw
    current_customer.is_deleted = true
    if current_customer.update
      redirect_to root_path
    end
  end

  # この下に何も記述しないこと！
  private

  def current_customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end

end
