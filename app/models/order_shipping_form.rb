class OrderShippingForm
  include ActiveModel::Model

  attr_accessor :name, :price, :description, :category_id, :user_id,
                :postal_code, :prefecture_id, :city, :address, :building, :phone_number
                
  with_options presence: true do
    validates :name
    validates :price
    validates :description
    validates :category_id
    validates :user_id
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number
  end

  def save
     item = Item.create(
      name: name,
      price: price,
      description: description,
      category_id: category_id,
      user_id: user_id
    )

     Shipping.create(
      item_id: item.id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number
    )
  end
end