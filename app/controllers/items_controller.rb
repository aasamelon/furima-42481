class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
    #@sold_out = false
  end

  def edit
    @item = Item.find(params[:id])
      unless current_user == @item.user
        redirect_to root_path
      end

   @categories = Category.all
   @conditions = Condition.all
   @shipping_fees = ShippingFee.all
   @prefectures = Prefecture.all
   @shipping_days = ShippingDay.all
  end

  def update
    @item = Item.find(params[:id])

    if params[:item][:image].blank? && @item.image.attached?
      params[:item].delete(:image)
    end

    if @item.update(item_params)
     redirect_to @item
    else

      @categories = Category.all
      @conditions = Condition.all
      @shipping_fees = ShippingFee.all
      @prefectures = Prefecture.all
      @shipping_days = ShippingDay.all

     render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :shipping_fee_id,
      :prefecture_id, :shipping_day_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end
