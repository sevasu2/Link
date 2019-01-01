class MembersController < ApplicationController
  before_action :login_required

  def index
    @members = Member.order("number")
      .page(params[:page]).per(15)
  end

  def search
    @members = Member.search(params[:q])
      .page(params[:page]).per(15)

    render "index"
  end

  def show
    @member = Member.find(params[:id])
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :admin_members, notice: "会員を削除しました。"
  end

end