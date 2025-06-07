class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: { message: "can't be blank" }

  validates :password, format: {
    with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
    message: 'is invalid. Include both letters and numbers'
  }
  
  validates :last_name, presence: { message: "can't be blank" },
                        format: {
                          with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
                          message: 'is invalid. Input full-width characters'
                        }

  validates :first_name, presence: { message: "can't be blank" },
                         format: {
                           with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
                           message: 'is invalid. Input full-width characters'
                         }

  validates :last_name_kana, presence: { message: "can't be blank" },
                             format: {
                               with: /\A[\p{katakana}ー－]+\z/,
                               message: 'is invalid. Input full-width katakana characters'
                             }

  validates :first_name_kana, presence: { message: "can't be blank" },
                              format: {
                                with: /\A[\p{katakana}ー－]+\z/,
                                message: 'is invalid. Input full-width katakana characters'
                              }

  validates :birthday, presence: { message: "can't be blank" }
end
