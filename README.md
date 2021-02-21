# 選挙アプリケーション

# １ 概要

## 有権者登録

## 立候補機能

## 立候補者情報の表示機能

## 立候補者との意見交換機能（チャット機能）

## 投票機能

## 票数を集計し結果を表示する機能

## 投票締切以降は選挙結果しか表示されない

投票が締め切られた後は、トップページに遷移しようとすると選挙結果が表示される
https://gyazo.com/0f012241741f96b6bc8b02df6ef9ee58

# 2 本番環境

## デプロイ先

https://election-app-33051.herokuapp.com

## テストアカウント

### アドレス

aaa@bbb

### パスワード

111111

### 立候補機能と投票機能を利用する場合

立候補機能と投票機能は、一有権者につき一度のみしか行えないため、これらの機能を動かす場合はアカウントを作成してください

# 3 制作の意図

２０２０年はアメリカ大統領選挙が話題となり、不正の有無が大きな話題となりました。
他方、この年は世界的な新型コロナウィルスのパンデミックが起こり、日本でも、外出を控え、人混みを避ける状況となりました。
ところが、民主国家においては選挙は不可欠ですから、いかなる社会情勢であっても省略することはできません。家にいながらにして投票できる制度があれば、有権者の便宜に資するし、集計に伴う人的、時間的コストも格段に削減できることから、将来的には必ずオンラインによる投票が実現されるはずであると考え作成に取り掛かりました。

# 4 工夫した点

## 一有権者、一立候補、一投票を厳格にすること

重複保存しないようにバリデーションを設ける
混乱回避のため遷移できるボタンを消去させる

## チャットルームの発言者を左右に振り分ける

発言者が当該立候補者と一致する場合とそうでない場合に分けて表示先を変える

## 投票結果は投票締め切り後にはじめて表示できるようにする

## 見た目は極力簡素にすること

# 5 使用技術(開発環境)

ruby on rails
javascript

# 6 課題や今後実装したい機能

現状具対的な一つの選挙にしか対応しておらず、汎用性を持たせるためには本来ならば選挙自体を生成できるようにテーブルを増設すべきところです


# 7 テーブル設計

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
| electorate_id        | references | null: false, foreign_key: true |


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
