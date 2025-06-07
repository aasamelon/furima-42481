class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: { message: "can't be blank" }

  validates :email, presence: { message: "can't be blank" } # ← is invalid 消したい場合 format削除
  # validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/, message: 'is invalid' # ← 削除してOK

  validates :password, presence: { message: "can't be blank" },
                       length: { minimum: 6, message: nil }, # ← メッセージなしに
                       format: {
                         with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
                         message: 'is invalid. Include both letters and numbers'
                       },
                       confirmation: true

  validates :password_confirmation, presence: { message: "can't be blank" }

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
                               with: /\A[ァ-ンヴー]+\z/,
                               message: 'is invalid. Input full-width katakana characters'
                             }

  validates :first_name_kana, presence: { message: "can't be blank" },
                              format: {
                                with: /\A[ァ-ンヴー]+\z/,
                                message: 'is invalid. Input full-width katakana characters'
                              }

  validates :birthday, presence: { message: "can't be blank" }
end
