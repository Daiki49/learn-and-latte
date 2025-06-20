# サービス名：『Learn & Latte』

## 目次
- [サービス概要](#サービス概要)
- [サービスURL](#サービスurl)
- [サービス開発の背景](#サービス開発の背景)
- [機能紹介](#機能紹介)
- [技術構成について](#技術構成について)
  - [使用技術](#使用技術)
  - [ER図](#er図)
  - [画面遷移図](#画面遷移図)
<br>

# サービス概要
『Learn & Latte』は、勉強に適したカフェを検索・レビューできるサービスです。<br>
- 「静かな雰囲気かどうか」等、勉強のしやすさに特化した視点で、カフェのレビューを投稿・閲覧できます。
- 現在地情報をもとに近くのカフェを探したり、店名や住所等のキーワードから検索することができます。
<br>

## サービスURL
### https://learnandlatte.jp/<br>
<br>

## サービス開発の背景
RUNTEQの学習期間中、平日は遅くまで仕事をしているため、自宅へ帰ると疲れてそのまま寝てしまうことが多く、学習の時間を確保するためにカフェで勉強する習慣ができました。休日も予定の合間にカフェを活用することが多かったのですが、「どこが勉強に向いているか」を調べるのが意外と手間で、毎回探すのが面倒に感じていました。<br>
<br>
同じように、Wi-Fiや電源がある勉強向きのカフェを探すのに苦労しているRUNTEQの同期もおり、**「勉強しやすいカフェの情報を共有できるサービスがあれば便利なのでは」と考えたことが、開発のきっかけです。**<br>
<br>
現在、多くのレビューサイトでは利用目的が多岐にわたるため、自分の目的（例えば「勉強」）に合った情報を見つけるには時間がかかることがあります。そこで、本サービスでは「勉強のしやすさ」に特化したレビューを集めることで、**カフェで勉強したい人が、自分に合ったお店を素早く見つけられるような体験を提供したいと考えました。**<br>
<br>

## 機能紹介
### 【主な機能】
- マップ検索*：現在地を取得し、周辺のカフェをマップ上で探すことができます。
- キーワード検索*：店名、住所といったキーワードで該当するカフェを検索できます。
- 店舗詳細情報*：「住所（所在地を地図上で表示）」、「営業時間」及び「レビュー」を確認できます。
- ブックマーク：お気に入りのカフェをブックマークできます。
- レビュー投稿：「評価」、「レビューの文章」及び「画像」を投稿できます。
- レビューへのいいね：投稿されたレビューに対していいねができます。
- マイページ：「プロフィールの編集」、「投稿したレビューの表示」、「いいねしたレビュー一覧の表示」ができます。<br><br>
*ユーザー登録なしで利用できる機能
### 【その他】
- Google認証によるユーザー登録・ログイン機能
- パスワードリセット機能
- キーワード検索時のオートコンプリート(店名、住所)
- Xシェア機能（店舗情報、レビュー投稿）
- お問い合わせフォーム
- 利用規約
- プライバシーポリシー

## 技術構成について

### 使用技術
| カテゴリ | 技術内容 |
| --- | --- |
| サーバーサイド | Ruby on Rails 7.1.3 / Ruby 3.2.3 |
| フロントエンド | HTML / CSS / JavaScript |
| CSSフレームワーク | Tailwind CSS / daisyUI |
| データベース | PostgreSQL |
| インフラ | Render / AWS S3 |
| バージョン管理 | Git / GitHub |
<br>

## ER図
[![Image from Gyazo](https://i.gyazo.com/a69b9b47e74c1eb99250e806bbd8f90d.png)](https://gyazo.com/a69b9b47e74c1eb99250e806bbd8f90d)
<br>

## 画面遷移図
Figma：https://www.figma.com/board/SEE0eMpxiAMWMFiydNMq1d/Learn%26Latte-%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?node-id=0-1&t=Tp1JJQ16Iu0p6FWA-1
