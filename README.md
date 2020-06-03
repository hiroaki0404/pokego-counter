# GOカウンター
ポケモンGOの「自分」の画面にある経験値を取得します。

## 使い方
このBotのいるチャットルームで、ポケモンGOの「自分」の画面
(左下のプレーヤーをタッチして表示される画面) の画面キャプチャを
送信します。 
現在のレベルをクリアするために必要な経験値(XP)を、何％獲得できているか、返します。

## プログラムについて
[Heroku](https://heroku.com)で動かすことを想定しています。
画像から経験値を取得する部分は
[Tesseract](https://github.com/tesseract-ocr/tesseract) を使用しています。
Herokuの実行環境に含まれていることを想定しているため、設定方法については記載しません。

## 必要な環境変数
| 変数名 | 内容 |
| ----- | ---- |
| LINE_CHANNEL_ID | LINEのチャネルID |
| LINE_CHANNEL_SECRET | LINEのチャネルシークレット |
| LINE_CHANNEL_TOKEN | LINEのアクセストークン |
| TESSDATA_DIR | Tesseractのdataファイルのあるディレクトリ |

※ LINEに関する上記設定項目はLINE Developersの画面で確認してください。  
※ Herokuを使う場合、buildpackによって Tesseract のインストール先が変わります。

## 追加したい機能

- 獲得％の推移をわかるようにしたい
- 上記をグラフ表示したい
