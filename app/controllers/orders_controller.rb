class OrdersController < ApplicationController
  before_action :set_item

  def index
    @order_shipping_form = OrderShippingForm.new
  end

  def create
    @order_shipping_form = OrderShippingForm.new(order_params.merge(
      user_id: current_user.id,
      item_id: @item.id
    ))

    if @order_shipping_form.valid?
      @order_shipping_form.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_shipping_form).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building_name,
      :phone_number
    )
  end
end
