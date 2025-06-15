class OrdersController < ApplicationController
  def index
    @order_shipping_form = OrderShippingForm.new
    @item = Item.find(params[:item_id])
end
