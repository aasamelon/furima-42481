# テーブル設計

## users テーブル

| Column              | Type    | Options     |
| ------------------  | ------  | ----------- |
| nickname            | string  | null: false |
| email               | string  | null: false, unique: true |
| encrypted_password  | string  | null: false |
| last_name           | string  | null: false |
| first_name          | string  | null: false |
| last_name_kanji     | string  | null: false |
| first_name_kanji    | string  | null: false |
| last_name_hiragana  | string  | null: false |
| first_name_hiragana | string  | null: false |
| last_name_kana      | string  | null: false |
| first_name_kana     | string  | null: false |
| birth_date          | string  | null: false |

### Association
- has_many :items
- has_many :orders

## items テーブル

| Column             | Type       | Options     |
| ------------------ | -----------| ----------- |
| name               | string     | null: false |
| description        | text       | null: false | 
| category           | string     | null:false  |
| condition          | string     | null: false |
| shipping_fee       | string     | null: false |
| prefecture         | string     | null: false |
| shipping_day       | string     | null: false |
| price              | integer    | null: false |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## orders テーブル
| Column             | Type       | Options                        |
| ------------------ | -----------| ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## address テーブル
| Column             | Type       | Options                        |
| ------------------ | -----------| ------------------------------ |
| postal_code        | string     | null: false                    |
| prefecture         | string     | null: false                    |
| city               | string     | null: false                    |
| address            | string     | null: false                    |
| building_name      | string     | null: false                    |
| phone_number       |string      | null: false                    |

### Association
- has_one :order