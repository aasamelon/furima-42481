class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  #has_one :order#
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price
  end

  validates :category_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :condition_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :shipping_fee_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "を選択してください" }

  validate :price_must_be_number_and_in_range

  private

  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: "は¥300〜¥9,999,999の間で入力してください"
   }
  end

    num = price.to_i
    if num < 300
      errors.add(:price, "は¥300〜¥9,999,999の間で入力してください")
    elsif num > 9_999_999
      errors.add(:price, "は¥300〜¥9,999,999の間で入力してください")
    end
  end
end
