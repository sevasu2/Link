class AccountsController < ApplicationController
  before_action :login_required #ログインする前に要求するメソッド
  before_action :set_target_account, only: %i[show edit update ]

  #アカウント詳細
  def show
  end

  #アカウント編集
  def edit
  end

  # アカウント更新
  def update
    @member.assign_attributes(account_params) #入っているデータの反映
    if @member.save #保存できた場合
      redirect_to :account, notice: "アカウント情報を更新しました。" #アカウント詳細ページへ遷移、メッセージ表示
    else #保存できない場合
      render "edit" #編集ページへ
    end
  end


  # ストロング・パラメータ
  private def account_params
    params.require(:account).permit(
      :new_profile_picture,
      :remove_profile_picture,
      :number,
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

  # 共通部分の統合（リファクタリング）
  def set_target_account
    @member = current_member #ログインしているメンバーの値
  end
end
