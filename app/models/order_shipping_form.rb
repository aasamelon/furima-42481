class OrderShippingForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id,
                :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token

validates :postal_code, presence: { message: "can't be blank" },
                         format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter as 123-4567" }

validates :prefecture_id, numericality: { other_than: 0, message: "must be selected" }

validates :city, presence: { message: "can't be blank" }

validates :address, presence: { message: "can't be blank" }

validates :phone_number, presence: { message: "can't be blank" },
                         format: { with: /\A\d{10,11}\z/, message: "is invalid. Input only numbers" }

validates :token, presence: { message: "can't be blank" }


  def save
    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)
      Shipping.create!(
        order_id: order.id,
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building_name: building_name,
        phone_number: phone_number
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
