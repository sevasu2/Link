①デプロイ環境

Ruby2.3.8

Rails5.2.1

MySQL5.7

②文字コードをutf8mb4で指定する場合、マイグレーションファイルに特別に記述を追加する
各createマイグレーションファイルに下記の記述に書き換える。
create_table :users, :options => 'ENGINE=InnoDB ROW_FORMAT=DYNAMIC' do |t|

・初回実行コマンド
$ bundle exec rake assets:precompile RAILS_ENV=production

$ bundle exec rake db:migrate RAILS_ENV=production

$ bundle exec rake db:seeds RAILS_ENV=production

$ sudo service httpd restart


③実装した機能


⑴画像投稿機能

⑵ログイン機能

⑶CRUD機能

⑷会員と非会員での閲覧制限機能

⑸ニュースの自動表示終了機能

⑹ポートフォリオの下書き、会員、非会員の制限機能

⑺ポートフォリオのいいね機能

⑻会員検索機能

⑼マイページ機能

⑽URLの文字列をURLにする機能

・管理者の機能

ニュースのCRUD機能

会員のCRUD機能


会員の方の機能

自分で作ったポートフォリオの記事作成（画像も添付可）

公開の仕方は、下書き（自分だけが閲覧可）、会員限定、公開（非会員も閲覧可）と設定できます。

内容にURLをつけるとリンク先に飛べるようになってます。

いいと思ったポートフォリオにいいねできます。

右上の名前からアカウントの編集ができます。

他の会員の方の情報も閲覧可

ニュースは閲覧のみ可。

・非会員の方の機能

非会員にも公開されたニュースの閲覧

非会員にも公開されたポートフォリオ記事の閲覧
