# Magpie要件

## 概要
- 自分のコレクションを登録・管理できるアプリ

## 言語
- Ruby,JavaScript

## フレムワーク
- Ruby on Rails

## Gem
- devise

## 機能
### ログイン機能
- deviseを使用する
- ニックネーム、メールアドレス、パスワードを入力すると新規登録できる。
- ニックネーム、メールアドレス、パスワードは全て必須。
- 登録後、メールアドレスとパスワードでログインできる。
- ログインしていない状態では、コレクション一覧は閲覧・編集・削除等一切できない。

#### 入力項目
- ニックネーム
- メールアドレス
- パスワード


### アイテム登録機能
- 名前の入力は必須。他は任意。
- フォームに下記項目を記入し登録ボタンを押すとitemsテーブルに登録される。
- tagsテーブルにも保存される。

#### 入力項目
- 画像
- 名前
- タグ
- コンディション (Active hash)
- レア度 (Active hash)
- 型番
- 入手ルート
- 発売日
- memo


### アイテム一覧機能
- 登録したアイテムがトップページに一覧で新しい順に10件表示される

### アイテム詳細機能
- クリックするとアイテムの詳細が表示される
- 編集ボタンと削除ボタンがある

### アイテム編集機能
- 登録したアイテムの情報を編集する
- 変更せずに更新を押しても空欄にならない
- 戻るを押すと元のページに戻る

### アイテム削除機能
- 登録したアイテムを削除できる

### タグ登録機能
- 商品登録時にタグを登録できる
- ✳︎カンマで区切って複数入力できる
- ✳︎インクリメンタルサーチ

### タグ検索機能
- ✳︎タグで検索できる


## テーブル設計

### users
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| nickname           | string     | null: false                    |
| email              | string     | null: false, unique: true      |
| encrypted_password | string     | null: false                    |

### items
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| condition_id       | integer    |                                |
| rarity_id          | integer    |                                |
| product            | string     |                                |
| release            | date       |                                |
| route              | string     |                                |
| get_date           | date       |                                |
| memo               | text       |                                |

#### Association
- has_many :tags, through: :tagging


### tags
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| tag_name           | string     | foreign_key: true              |

#### Association
- has_many :items, through: :tagging


### tagging
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_id            | references | foreign_key: true              |
| tag_id             | references | foreign_key: true              |

#### Association
- belongs_to :post
- belongs_to :tag