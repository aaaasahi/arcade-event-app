# アケイベ
[https://arcade-event.com/](https://arcade-event.com/)

ログインページのゲストユーザーボタンからゲストユーザーとしてログイン可能です。

### Admin User

ログインページから以下を入力していただくと管理者としてログイン可能です。

Email : [arcade.event111@gmail.com](mailto:arcade.event111@gmail.com)

password : admin1017

# アプリ概要
**コロナ渦で消えゆくゲームセンターを救いたい!** という気持ちで作成したゲームセンター開催限定のイベント投稿型サービスです。

# 作成した背景
### ゲームセンター を救いたいという想い

私は元々ゲームセンターで働き、休日でも色々なゲームセンターに通うくらいゲームセンター独特の雰囲気、コミュニティが大好きでした。
そんな大好きなゲームセンターがコロナ渦で続々と閉店していくのを見て今の自分に何ができるのかを考え作成しました。

イベント投稿型にした理由、

- イベントを開催することでコミュニティが広がるだけじゃなく集客にも繋がりやすい。
- ゲームセンター側での告知(Twitter、HP)だけでは限界があることを知っている。
- イベント主催者をお客さん側に任せることでゲームセンター側の人件費が減らせる。

このサービスで少しでもゲームセンターに通ってくれる人が増えること願っています。

# 工夫したこと
### N+1問題を解消し処理時間を短縮させた

投稿が増えるにつれて読み込み時間が長くなるのはユーザーが利用する上で不便になると感じました。

原因を調べるためにターミナルでログを確認したところ、N+1問題が発生していることが分かったのでN+1問題を検知するbulletというgemがあることを知り、こちらを導入して問題箇所を特定。

主に画像投稿機能として使用したactive storageによるものだと分かったのでActive Storage上で用意された`with_attached_attachment_name`というスコープを使用することで読み込み時間を短縮することができました。

### 運用を考えたオリジナルの管理者機能

運用する上でサービスのアクティブ状況が分かるアナリティクス機能を入れたかったのでオリジナルの管理者機能を作成しました。

主な機能としては、

- ユーザー登録状況、イベント投稿状況をChartで表示
- 全てのユーザー、イベント情報と前日のユーザー、イベント情報を表で表示しPDF出力可能に
- バッジ処理とAction Mailerを使用しAdmin Userに現在のユーザー、イベント数と前日のユーザー登録数、イベント投稿数を毎朝6時にメール配信

今後迷惑な投稿やユーザーを削除できる機能を追加予定です。

## 特に見て欲しい点

### 小さく作りgithubのリポジトリとして残すまたQiitaにも投稿

各機能を実装する際、ただ実装して終わりではなく、機能ごとにgithubにリポジトリを作りドキュメント化することで 記憶ではなく記録に残るようにしました。

GitHubにリポジトリとして残すことで次回同じ機能を実装することがあった場合その機能を高速に実装することができます。このようにドキュメンテーション力を活かして知識を積み上げていけることが私の強みです。

GitHubリポジトリ一覧、
- [タグ機能](https://github.com/aaaasahi/rails-search-app)
- [Google Map APIを使用したMAP表示](https://github.com/aaaasahi/g-map-api-sample-app)
- [DM機能](https://github.com/aaaasahi/dm-function-app)

Qiitaに投稿するということは自分の言葉で噛み砕きまとめなければならないので、その結果より深く理解することができました。

Qiita記事一覧、
- [[Rails] DM機能を解説する](https://qiita.com/aaaasahi_17/items/9e7f344488c720aaf116)
- [[Rails] 投稿した住所をGoogle Map APIを使ってMapで表示する](https://qiita.com/aaaasahi_17/items/8784ce1517c58510f0b8)
- [ActionMailer、Rakeタスク、wheneverで作るメール自動配信機能](https://qiita.com/aaaasahi_17/items/fb19d295ae2ea699ccca)
- [[Rails] オリジナルの管理者機能を作る 管理者画面編](https://qiita.com/aaaasahi_17/items/fbd5cdcdc2a1f1591d8b)

### 言語切り替え

ゲームセンターで働いていた際、お客様として日本だけでなく海外の方もよく来店されることがあったので海外の方でもこのサービスを使ってもらえるようページ下の言語ボタンを押すことでほぼ全てのページで多言語化に対応しています。

現在対応しているのは英語だけですが今後中国語など様々な言語に対応していきたいです。

# 苦労したこと

### イベント自動Close機能

イベント開催日が過ぎたイベントを自動でcloseする機能。ネット上に参考文献がなく、自力で実装していく必要がありました。

機能要件を作成し実装の手順を具体的にしてから実装しました。

具体的な方法は、下記になります。

- イベントの期日が過ぎたイベントを論理削除する
    - イベントカラムにbooleanを持たせる
    - 開催日が過ぎたイベントのbooleanの状態でViewの表示を変更する

- 論理削除はイベント期日が過ぎたら自動で実行
    - イベント開催日が過ぎたらbooleanを変更するメソッドを定義
    - そのメソッドをrakeタスクに登録
    - rakeタスクを定期実行する

この経験から、未知の機能に対して自ら問題を定義して解決するための試行錯誤とやり遂げる経験を得ました。

この時の様子をQiitaにもまとめました。
[イベントclose機能を作ってみた(論理削除)](https://qiita.com/aaaasahi_17/items/c9a011b085ecc076bca1)

### action text 検索問題

イベント投稿のエディターとしてaction text、検索機能としてgem ransackを使用していたのですがaction textとransackの相性が悪くaction textで投稿した内容で検索ができないという不具合が発生しました。

なぜ動かないのかという現状を把握した上でSQLの内部結合を用いてaction textの内容でも検索できるように検索機能を自作しました。

この経験から不具合に対しては現状を把握すること、gemではなく自作で作る適応力を得ました。

この時の様子をQiitaにもまとめました。
[Action Textとransackの相性が悪くて困った](https://qiita.com/aaaasahi_17/items/d2fafec5e16de980a03d)

## その他工夫したこと

- 機能数
- 大手のイベントアプリを参考に直感でわかるUI/UX
- Rubocopを導入してコードの品質を担保
- RSpecを使用して、100件以上のテストコード
- 実際のWebサービスを想定し本番環境にAWSを採用

# アプリの使い方

# 機能一覧
## ユーザー機能一覧
- 新規登録、ログイン機能(devise)
- ゲストログイン機能

## 管理者機能一覧
- ユーザー、イベント状況Chart表示(chartkick)
- ユーザー、イベント情報PDF出力(wicked_pdf)
- イベント、ユーザー情報管理者にMail定期配信(whenever)

## イベント機能一覧
- イベント投稿機能
  - 画像投稿機能
  - 画像プレビュー機能
  - カテゴリ投稿機能(active hash)
  - 住所投稿によるMAP表示機能(Google API)
  - タグ投稿機能
- イベント詳細機能
  - コメント機能
  - 参加機能(Ajax)
  - クリップ機能(Ajax)
- イベント編集、削除機能
- カレンダー機能(SimpleCalendar)
- パンクズ機能(gretel)

## 検索機能一覧
- キーワード検索(ransack)
- カテゴリ検索
- タグ検索
- ソート機能
- ページネーション機能(kaminari)

## マイページ機能一覧
- 投稿イベント一覧機能
- 参加イベント一覧機能
- クリップイベント一覧機能
- DM機能
- プロフィール編集機能
- Email Password変更機能
- 退会機能

## その他
- 通知機能
- イベントClose機能(whenever)
- 言語切り替え機能
- テスト機能(rspec)

# 使用技術

- 言語：Ruby (3.0.0)
- フレームワーク：Ruby on Rails (6.1.3)
- フロントエンド：HTML/Scss/JavaScript
- DB：PostgreSQL
- インフラ：AWS (VPC | RDS | EC2 | S3 | Route53 | ACM| ALB）
- ソースコード管理：GitHub

# ER図
<img width="998" alt="arcade-eventER図" src="https://user-images.githubusercontent.com/69437267/133543618-e13c51c6-c3e0-407b-8f38-d5f49c801492.png">

