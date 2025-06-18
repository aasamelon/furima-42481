# spec/factories/order_shipping_forms.rb
FactoryBot.define do
  factory :order_shipping_form do
    postal_code   { '123-4567' }
    prefecture_id { 2 }
    city          { '渋谷区' }
    address       { '1-1' }
    building_name { 'マンション101' }
    phone_number  { '09012345678' }
    token         { 'tok_abcdefghijk00000000000000000' }

    transient do
      user { nil }
      item { nil }
    end

    initialize_with do
      OrderShippingForm.new(
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building_name: building_name,
        phone_number: phone_number,
        token: token,
        user_id: user&.id,
        item_id: item&.id
      )
    end
  end
end
