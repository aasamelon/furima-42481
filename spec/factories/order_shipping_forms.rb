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
  end
end
