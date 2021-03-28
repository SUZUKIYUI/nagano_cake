class Public::AddressesController < ApplicationController

  def index
    @address=Address.new
    @addresses=Address.all
  end

  def edit
    @address=Address.find(params[:id])
  end

  def create
    @address=Address.new(address_params)
    @address.customer_id=current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      render :index
    end
  end

  def update
    @address=Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address=Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  # この下に何も記述しないこと！
  private

  def address_params
    params.require(:address).permit(:postal_code,:address, :name)
  end

end
