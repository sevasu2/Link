class AccountsController < ApplicationController
  before_action :login_required #ログインする前に要求するメソッド

  #アカウント詳細
  def show
    @member = current_member #ログインしているメンバーの値
  end

  #アカウント編集
  def edit
    @member = current_member #ログインしているメンバーの値
  end

  # アカウント更新
  def update
    @member = current_member #ログインしているメンバーの値
    @member.assign_attributes(account_params) #入っているデータの反映
    if @member.save #保存できた場合
      redirect_to :account, notice: "アカウント情報を更新しました。" #アカウント詳細ページへ遷移、メッセージ表示
    else #保存できない場合
      render "edit" #編集ページへ
    end
  end

  #アカウント削除
  def destroy
    @member = Member.find(params[:id]) #メンバーidがあるデータを取ってくる
    @member.destroy
    redirect_to :root, notice: "ご利用ありがとうございました。退会が完了しました。" #トップページに遷移
  end

  # ストロング・パラメータ
  private def account_params
    params.require(:account).permit(
      :new_profile_picture,
      :remove_profile_picture,
      :name,
      :sex,
      :birthday,
      :address,
      :introduction,
      :email,
      :git,
      :introduction_name,
      :portfolio,
      :school
    )
  end
end
