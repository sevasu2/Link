class SessionsController < ApplicationController

  #新規作成
  def create
    member = Member.find_by(name: params[:name]) #名前のデータを1つ取ってくる
    if member&.authenticate(params[:password]) #会員でパスワードがある場合
      session[:member_id] = member.id #会員idを入れる
      redirect_to :entries #ポートフォリオ一覧へ
    else #そうでない場合
      flash.alert = "名前とパスワードが一致しません"
      redirect_to :root #トップページへ
    end

  end

  #削除
  def destroy
    session.delete(:member_id)
    redirect_to :root
  end
end
