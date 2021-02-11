# 選挙アプリケーション
# テーブル設計

## candidatesテーブル

| Colum                | Type       | Options                        |
|----------------------|------------|--------------------------------|
| last_name            | string     | null: false                    |
| first_name           | string     | null: false                    |
| last_name_kana       | string     | null: false                    |
| first_name_kana      | string     | null: false                    |
| birth_date           | date       | null: false                    |
| age                  | integer    | null: false                    |
| gender_id            | integer    | null: false                    |
| occupation           | string     | null: false                    |
| birth_place          | string     | null: false                    |
| education            | string     | null: false                    |
| political_party      | string     | null: false                    |
| experience_id        | integer    | null: false                    |
| career               | text       |                                |
| public_commitment    | text       |                                |
| electorate_id         | references | null: false, foreign_key: true |


### Association

- has_many :vote
- belongs_to : electorate
- has_one :room

## electoratesテーブル

| Colum      | Type       | Options                        |
|------------|------------|--------------------------------|
| email      | string     | null: false                    |
| nickname   | string     | null: false                    |
| password   | string     | null: false                    |

### Association

- has_many :messages
- has_one :vote
- has_one :candidate

## roomsテーブル

| Colum              | Type       | Options                        |
|--------------------|------------|--------------------------------|
| candidate_id       | references | null: false, foreign_key: true |

### Association

- has_many :messages


## messagesテーブル

| Colum         | Type       | Options                        |
|---------------|------------|--------------------------------|
| content       | text       | null: false                    |
| room_id       | references | null: false, foreign_key: true |
| candidates_id | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs-to :electorate



## votesテーブル

| Colum              | Type       | Options                        |
|--------------------|------------|--------------------------------|
| candidate_id       | references | null: false, foreign_key: true |
| electorate_id      | references | null: false, foreign_key: true |

### Association

- belongs_to :candidate
- belongs-to :electorate
