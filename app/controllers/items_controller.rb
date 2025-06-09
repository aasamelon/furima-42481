class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def new
  @item = Item.new
  end

  def item_params
    params.require(:item).permit(:content, :image).merge(user_id: current_user.id)
  end

   def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end 

end
