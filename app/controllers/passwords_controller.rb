class PasswordsController < ApplicationController
  before_action :login_required

  # 詳細ページ
  def show
    redirect_to :account
  end

  #編集ページ
  def edit
    @member = current_member
  end

  #更新
  def update
    @member = current_member
    current_password = account_params[:current_password]

    if current_password.present? #パスワードはあるか
      if @member.authenticate(current_password) #パスワードを認証する場合
        @member.assign_attributes(account_params) #パスワードを割り当てる
        if @member.save #保存できた場合
          redirect_to :account, notice: "パスワードを変更しました。"
        else #保存できない場合
          render "edit"
        end
      else #パスワード認証ができない場合
        @member.errors.add(:current_password, :wrong)
        render "edit"
      end
    else #パスワードがない場合
      @member.errors.add(:current_password, :empty)
      render "edit"
    end
  end

  #ストロングパラメーター
  private def account_params
    params.require(:account).permit(
      :current_password,
      :password,
      :password_confirmation
    )
  end
end
