class MembersController < ApplicationController
  before_action :login_required #ログインしているか

  #一覧ページ
  def index
    @members = Member.order("number")
      .page(params[:page]).per(15)
  end

  # 検索
  #qに検索ワードが入る
  def search
    @members = Member.search(params[:q])
      .page(params[:page]).per(15)

    render "index"
  end

  #詳細ページ
  def show
    @member = Member.find(params[:id])
  end

end