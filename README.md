# テーブル設計

## candidatesテーブル

| Colum                | Type    | Options     |
|----------------------|---------|-------------|
| last_name            | string  | null: false |
| first_name           | string  | null: false |
| last_name_kana       | string  | null: false |
| first_name_kana      | string  | null: false |
| birth_date           | date    | null: false |
| gender_id            | integer | null: false |
| occupation           | string  | null: false |
| education            | string  | null: false |
| career               | text    |             |
| public_commitment    | text    |             |


### Association

- has_many :vote
- belongs_to : electorate

## electoratesテーブル

| Colum      | Type       | Options                        |
|------------|------------|--------------------------------|
| email      | string     | null: false                    |
| nickname   | string     | null: false                    |
| password   | string     | null: false                    |

### Association

- has_many :electorate_messages
- has_one :vote
- has_one :candidate

## roomsテーブル

| Colum     | Type       | Options                        |
|-----------|------------|--------------------------------|

### Association

- has_many :messages


## messagesテーブル

| Colum         | Type       | Options                        |
|---------------|------------|--------------------------------|
| content       | text       | null: false                    |
| room_id       | references | null: false, foreign_key: true |
| candidates_id | references | null: false, foreign_key: true |

### Association

- belongs_to :rooms
- belongs-to :candidates



## votesテーブル

| Colum              | Type       | Options                        |
|--------------------|------------|--------------------------------|
| candidate_id       | references | null: false, foreign_key: true |
| electorate_id      | references | null: false, foreign_key: true |

### Association

- belongs_to :candidate
- belongs-to :electorate
