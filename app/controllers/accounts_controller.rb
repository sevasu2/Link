class AccountsController < ApplicationController
  before_action :login_required

  def show
    @member = current_member
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    @member.assign_attributes(account_params)
    if @member.save
      redirect_to :account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :root, notice: "ご利用ありがとうございました。退会が完了しました。"
  end

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
