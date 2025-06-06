class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'は@を含む正しい形式で入力してください' }

  validates :password, presence: true,
                       length: { minimum: 6 },
                       format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は半角英数字混合で入力してください' },
                       confirmation: true

  validates :password_confirmation, presence: true

  validates :last_name, presence: true,
                        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }

  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }

  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ンヴー]+\z/, message: 'は全角カタカナで入力してください' }

  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ンヴー]+\z/, message: 'は全角カタカナで入力してください' }

  validates :birthday, presence: true
end
