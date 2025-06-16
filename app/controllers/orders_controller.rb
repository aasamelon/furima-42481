class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_shipping_form = OrderShippingForm.new
end
