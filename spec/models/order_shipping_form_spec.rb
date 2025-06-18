require 'rails_helper'

RSpec.describe OrderShippingForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_shipping_form = FactoryBot.build(:order_shipping_form, user: @user, item: @item)
  end

  describe '配送先の住所情報の保存' do
    context '内容に問題がない場合' do
      it '全て正しく入力されていれば保存できる' do
        expect(@order_shipping_form).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_shipping_form.building_name = ''
        expect(@order_shipping_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できない' do
        @order_shipping_form.postal_code = ''
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が「3桁-4桁」の形式でないと保存できない' do
        @order_shipping_form.postal_code = '1234567'
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '都道府県が0だと保存できない' do
        @order_shipping_form.prefecture_id = 0
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空だと保存できない' do
        @order_shipping_form.city = ''
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと保存できない' do
        @order_shipping_form.address = ''
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと保存できない' do
        @order_shipping_form.phone_number = ''
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では保存できない' do
        @order_shipping_form.phone_number = '090123456'
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が12桁以上では保存できない' do
        @order_shipping_form.phone_number = '090123456789'
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号にハイフンが含まれていると保存できない' do
        @order_shipping_form.phone_number = '090-1234-5678'
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'user_idが空だと保存できない' do
        @order_shipping_form.user_id = nil
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと保存できない' do
        @order_shipping_form.item_id = nil
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では保存できない' do
        @order_shipping_form.token = nil
        @order_shipping_form.valid?
        expect(@order_shipping_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
