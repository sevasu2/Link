class EntriesController < ApplicationController
  before_action :login_required, except: [:index, :show] #一覧、詳細以外でログインしているか確認

  #ポートフォリオ一覧
  def index
  	 if params[:member_id] #会員のidがある場合
      @member = Member.find(params[:member_id]) #会員idのあるデータを取ってくる
      @entries = @member.entries #会員のポートフォリオ
    else #会員idがない場合
      @entries = Entry.all #全てのポートフォリオ
    end

    @entries = @entries.readable_for(current_member)
      .order(posted_at: :desc).page(params[:page]).per(5) #1ページに5記事表示
  end

  #ポートフォリオ詳細
  def show
    @entry = Entry.readable_for(current_member).find(params[:id]) #readable_forスコープで閲覧できる記事絞る
    @comments = @entry.comments
    @comment = Comment.new
  end

  #新規登録フォーム
  def new
  	@entry = Entry.new(posted_at: Time.current) #ポートフォリオのオブジェクト作成
  end

  #編集フォーム
  def edit
  	@entry = current_member.entries.find(params[:id]) #ログインしている人のポートフォリオ
  end

  # 新規作成
  def create
    @entry = Entry.new(entry_params) #入力ニュー力されたデータ
    @entry.author = current_member #ログインしている人
    if @entry.save #保存できた場合
      redirect_to @entry, notice: "記事を作成しました。" #詳細ページへ遷移
    else #そうでない場合
      render "new" #新規作成ページのまま
    end
  end

  # 更新
  def update
    @entry = current_member.entries.find(params[:id]) #ログインしている人のポーtーフォリオデータ
    @entry.assign_attributes(entry_params) #ポートフォリオデータの入っているもの
    if @entry.save #保存ができた場合
      redirect_to @entry, notice: "記事を更新しました。" #詳細ページへ遷移
    else #そうでない場合
      render "edit" #編集ページのまま
    end
  end

  # 削除
  def destroy
    @entry = current_member.entries.find(params[:id]) #ログインしている人のポートフォリオデータ
    @entry.destroy #削除する
    redirect_to :entries, notice: "記事を削除しました。" #ポートフォリオ一覧ページへ遷移
  end

  # 投票
  def like
    @entry = Entry.published.find(params[:id]) #公開されているポートフォリオidがあるもの取ってくる
    current_member.voted_entries << @entry #Memberモデルのvoted_entriesに対して<<でポートフォリオを関連づける
    redirect_to @entry, notice: "いいね！しました。" #詳細ページに遷移
  end

  # 投票削除
  def unlike
    current_member.voted_entries.destroy(Entry.find(params[:id])) #ログインしている会員の投票データを消す
    redirect_to :voted_entries, notice: "削除しました。" #いいねしたポートフォリオ一覧へ遷移
  end

  # 投票した記事
  #ログインしている会員の投票したポートフォリオ
  #投票した順で１ページに15個表示
  def voted
    @entries = current_member.voted_entries.published
      .order("votes.created_at DESC")
      .page(params[:page]).per(15)
  end

  # ストロングパラメーター
  private def entry_params
    params.require(:entry).permit(
      :member_id,
      :title,
      :body,
      :posted_at,
      :status
    )
  end
end
