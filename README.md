# 🚞 しぇあまど

![しぇあまど](https://github.com/jphacks/TK_2307/assets/67471192/41d4639d-b0af-44dc-b331-949aa43245cc)

## 🎥 デモ動画
https://youtube.com/shorts/GX1jUW0tjAQ?feature=share

## 📝 製品概要
しぇあまどは、退屈な移動時間と日常に新しい視点を提供し、知らなかった素敵な景色を見つけるためのアプリです。<br>
車窓スポットの投稿と共有の機能で、お気に入りの景色の共有と新たな発見を楽しめます。<br>

### ▶️ 背景(製品開発のきっかけ、課題等）
毎日の通勤通学中、スマホを見たり、ぼーっとしたりしている人が多く、そのような人たちの日常生活をより豊かにしたいと感じました。
特に社会人になると、毎日同じ時間に同じ電車に乗ることが多くなり、学生時代のように自由に日常生活に楽しいことを見つけるのが難しくなると考えました。<br>
そこで、私たちはそんな変わり映えしない日常を変化のある楽しめるものを作りたいと思いました。

### ▶️ 製品説明（具体的な製品の説明）
発表資料
https://1drv.ms/p/s!AskvRHPgeAdvjh6nozA5qsTQH7f4
## 🕊️ 特長
### 特長1
近くの車窓の写真が見られる！<br>
他の人が撮影した写真が表示されます。<br>
電車の窓から外を見てください、その写真と同じ景色が現れるかもしれません！<br>
また、違う季節の写真と見比べて、変化を楽しむこともできます。<br>
### 特長2
自分の好きな景色を共有できる！<br>
ふと電車から外を眺めると、「いい景色だな」と思うことはありませんか？<br>
ぜひ、写真に残して、他の人に共有しましょう！<br>

## ✨ 解決出来ること
* マンネリ化した日常生活に変化を与えることができる。
* 変わり映えしない日常を変化のある楽しいものにすることができる。
* 日常生活において新たな発見をすることができる。
* 他の人が自分と同じ路線での生活で知った発見を共有してもらうことができる。
* 自分の好きな車窓を共有することができる。

## 💭 今後の展望
* すれ違い通信のような機能を導入し、すれ違った人のお気に入りの車窓を共有できるようにする。
* 降りる駅でのリマインド機能を搭載する。
* 広告を導入し、その路線の地域活性に活かす。

## 💪 力を入れたこと・こだわり
* ユーザーが親しみがあり、見やすいデザインにするため、交通系アプリで浸透している緑色を中心とした配色に統一。
* ユーザーが触りたくなるようなボタン配置。
* バックグラウンドでも位置情報を取得可能。

## ⛏️ 開発技術
### 活用した技術
#### API・データ
* Google Maps API
* 国土数値情報 鉄道データ

#### フレームワーク・ライブラリ・モジュール
##### フロントエンド
* Flutter
* Dart
* Maps SDK for iOS
* (Maps SDK for Android)

##### バックエンド
* Firebase(Cloud Functions/Cloud Firestore/Cloud Storage)
* TypeScript

##### デバイス
* iOS
* (Android)

## 💫 独自技術
#### ハッカソンで開発した独自機能・技術
* 1万行を超えるJSONの鉄道データから、欲しい形式のデータ(オブジェクト)に変換し、Firestoreに投入する仕組み<br>
[CreateStationsBatch.ts](server/functions/src/batch/CreateStationsBatch.ts)
* スポット取得アルゴリズムは、件数増加の際のスケーラビリティを考慮し、現在地→近くの駅→周辺のスポットという順で取るように<br>
FirestoreはKeyValueのデータベースだが、外部キー的に各spotDocumentがstationDocumentIdを持ち、駅と紐づいている<br>
現在地→近くの駅、スポット→近くの駅は、それぞれユークリッド距離を算出して近いものを選ぶ<br>
[GetSpotsByLocationController.ts](server/functions/src/controller/spot/GetSpotsByLocationController.ts)
