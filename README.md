# DlJusyoJp
[住所.jp](http://jusyo.jp/index.html)様が提供している住所データをダウンロードし、ActiveRecordテーブルにインポートする処理をまとめてあります。

自分が複数のRails appで使い回すため、またダウンロードするファイルの形式やテーブルフォーマットが変わったとしても検知できるようにテストを書いたものです。


## 導入方法

Gemfileを追加して

```ruby
gem 'dl_jusyo_jp'
```

bundleして

    $ bundle

必要なファイルを生成します。

    $ rails generate dl_jusyo_jp:install

## 使い方

初版としては、一括で全国の情報を生成したテーブルにインポートする機能だけです。
以下をrailsコンソールで実行すれば完了です。
```ruby
DlJusyoJp::Import.execute
```

ダウンロードするテーブル名は dl_jusyo_jps となっています。
気に入らない、変えたいというときは
config/initializers/dl_jusyo_jp.rb を書き換えてください。


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dongoon/dl_jusyo_jp.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
