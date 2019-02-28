class Admin::ArticlesController < Admin::Base

  before_action :set_target_article, only: %i[show edit update destroy]

  # 記事一覧
  def index
    @articles = Article.order(released_at: :desc)
    .page(params[:page]).per(5)
      # ニュース記事を投稿順に並べ,１ページに５記事表示
  end

  # 記事詳細
  def show
  end

  # 新規登録フォーム
  def new
  	@article = Article.new #ニュースオブジェクト作成
  end

  # 編集フォーム
  def edit
  end

  # 新規作成
  def create
    @article = Article.new(article_params) #入力されたニュースデータ
    if @article.save #保存できた場合
      redirect_to [:admin, @article], notice: "ニュース記事を登録しました。" #管理者のニュース画面へ
    else #できない場合
      render "new" #新規投稿ページへ
    end
  end

  # 更新
  def update
    @article.assign_attributes(article_params) #ニュースの入っているデータを表示
    if @article.save #保存できた場合
      redirect_to [:admin, @article], notice: "ニュース記事を更新しました。" #管理者ニュース一覧へ
    else #保存できない場合
      render "edit" #データは送らず、ニュース編集画面へ
    end
  end

  # 削除
  def destroy
    @article.destroy #ニュースデータの削除
    redirect_to :admin_articles #管理者一覧ページへ
  end

  # ストロング・パラメータ
  private def article_params
    params.require(:article).permit(
      :title,
      :body,
      :released_at,
      :no_expiration,
      :expired_at,
      :member_only
    )
  end

  # リファクタリング
  def set_target_article
    @article = Article.find(params[:id]) #ニュースidの値があるものを取っててくる
  end
end
