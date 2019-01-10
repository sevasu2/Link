class ArticlesController < ApplicationController

  #ニュース一覧
  def index
    @articles = Article.visible.order(released_at: :desc) #掲載日時の新しいもの順
    @articles = @articles.open_to_the_public unless current_member #ログインユーザーでない場合、公開に設定されているもののみ表示
    @articles = @articles.page(params[:page]).per(5) #１ページに表示するのは5記事
  end

  #ニュース詳細
  def show
    articles = Article.visible #ニュースのデータ
    articles = articles.open_to_the_public unless current_member #ログインユーザーでない場合、公開に設定されているもののみ表示
    @article = articles.find(params[:id]) #１ページに表示するのは5記事
  end
end
