■サービス名（仮）
Learn & Latte

■サービス概要

- カフェで勉強する人向けのカフェのレビューサービス
- 具体的にはお店の雰囲気（にぎやかだったか、静かだったか）、座席の快適さ（勉強しやすい机や椅子だったか）、Wi-Fiは快適だったかなどカフェで勉強する人にとって過ごしやすい環境であったかを投稿し、共有できる
- ユーザーが勉強しやすいカフェを探しやすくするサービス

レビューで載せる項目としては下記を予定しております
- お店の雰囲気（にぎやかだったか、静かだったか）
- 座席の快適さ（勉強しやすい机や椅子だったか）
- Wi-Fiは快適だったか
- 電源は使えたか
- レビュー本文

カフェの情報を載せる範囲については東京のみ、現在地近くにある店舗を表示することを現状想定しております。

■ このサービスへの思い・作りたい理由

RUNTEQの学習期間中、平日の仕事後、家に帰ると疲れて寝てしまうため、カフェに寄って勉強することが多かった。休日も予定の合間にカフェに入って学習することもあった。  勉強しやすいカフェを探すのが面倒だった体験から勉強しやすいカフェをシェアするサービスがあったらいいなと思った。

■ ユーザー層について

- ユーザー層：カフェで勉強したい人、忙しい中勉強を頑張る人
- どうしてその層を対象にしたのか？：同じRUNTEQ生でもWi-Fiとコンセントがあって、勉強できるカフェを探すのに苦労した経験を持つ同期がいたため、ニーズがあるのではないかと思ったため

■サービスの利用イメージ

- ユーザーは他の人のレビューを参考にすることができ、勉強するカフェを探しやすくする価値を提供する
- 上記の価値を提供することで、ユーザーが隙間時間を効率的に活用して勉強できるようにする価値を提供できると考えます。

■ ユーザーの獲得について

カフェで勉強したい人という想定したユーザー層に対して、まずは以下のようにサービスを届けたいと考えています。
- mattermostのブログ記事・開発サービス紹介のチャンネルに投稿し、RUNTEQ生でカフェで勉強する人にサービスを届ける。
- 個人のTwitterアカウントにてサービス紹介のツイートを投稿し、フォロワーなどのプログラミングを勉強する人たちにサービスを届ける。

■ サービスの差別化ポイント・推しポイント

食べログなどの大規模なレビューサイトの場合、様々な目的でお店を利用している人のレビューがあるため、特定の目的でお店を利用したい場合において情報収集するのに手間がかかることがあると思います。  この点において、勉強しやすいカフェという対象を絞ったサービスにすることで、カフェで勉強する人目線で必要な情報を集めやすくすることで、差別化が図れると考えます。

■ 機能候補

MVPリリース時にはカフェのレビューを投稿・閲覧する機能に絞って開発していきたいと考えております。  本リリース時にはカフェのお店の情報を掲載し、その情報とレビューを紐づけられるようにすることで、よりユーザーが勉強しやすいカフェを探しやすくするサービスにしたいと考えています。

MVPリース
- トップページ
- レビューの検索・一覧表示
- 詳細
- レビュー投稿
- 会員登録・ログイン

本リリース
- いいね
- 店舗の検索・一覧表示・詳細
- 位置情報


■ 機能の実装方針予定

一般的なCRUD以外では、GoogleMapsAPI、GooglePlacesAPIを使った位置情報機能の実装、GooglePlacesAPIから取得した店舗情報を掲載することを現状考えています。

■ 技術スタック
- バックエンド：Rails7.1.3.2 / Ruby3.3.1
- フロントエンド：HTML / CSS / JavaScript
- データベース：Postgresql
- インフラ：Render

### 画面遷移図
Figma：https://www.figma.com/board/SEE0eMpxiAMWMFiydNMq1d/Learn%26Latte-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=Tp1JJQ16Iu0p6FWA-1

### READMEに記載した機能
- [x] ユーザー登録機能
- [x] ログイン機能
- [x] レビュー記事投稿機能（画像投稿含む）
- [x] レビュー記事閲覧機能（未ログインでも閲覧可能）
- [x] いいね機能
- [x] 店舗情報検索機能（未ログインでも閲覧可能）
- [x] 店舗情報閲覧機能（未ログインでも閲覧可能）

ER図：[![Image from Gyazo](https://i.gyazo.com/bfdac3cff7f02bde89de120905286538.png)](https://gyazo.com/bfdac3cff7f02bde89de120905286538)

