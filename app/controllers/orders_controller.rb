class OrdersController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_item
  before_action :redirect_if_invalid_access, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_shipping_form = OrderShippingForm.new
  end

  def create
    @order_shipping_form = OrderShippingForm.new(order_params.merge(
      user_id: current_user.id,
      item_id: @item.id
    ))

    if @order_shipping_form.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
      @order_shipping_form.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
    logger.debug "set_item: item_id=#{@item.id}"
  end

  
  def redirect_if_invalid_access
    logger.debug "redirect_if_invalid_access: current_user_id=#{current_user.id}, item_user_id=#{@item.user_id}, order_present=#{@item.order.present?}"
    if @item.user_id == current_user.id || @item.order.present?
      logger.debug "redirecting to root_path"
      redirect_to root_path and return
    end
  end

  def order_params
    params.require(:order_shipping_form).permit(
      :postal_code, :prefecture_id, :city, :address,
      :building_name, :phone_number, :token
    )
  end
end
