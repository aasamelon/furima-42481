class ItemsController < ApplicationController
def item_params
    params.require(:item).permit(:content, :image).merge(user_id: current_user.id)
  end
end
