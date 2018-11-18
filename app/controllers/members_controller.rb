class MembersController < ApplicationController
  before_action :login_required

    # 会員一覧
  def index
    @members = Member.all
    # if params[:name].present?
    #   @members = Member.search(params[:search])
    # end
    @members = @members.page(params[:page]).per(10)
  end

  # 検索
  def search
    if !params[:name].blank?
      @members = Member.where(["name LIKE ?", "%#{params[:name]}%"]).
        page(params[:page]).per(30) if params[:name].present?
    else
      @members = Member.order("created_at DESC").
        page(params[:page]).per(30)
    end
    render :action => "index"
  end

  # 会員情報の詳細
  def show
    @member = Member.find(params[:id])
  end
end