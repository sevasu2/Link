class Admin::MembersController < Admin::Base

  before_action :set_target_member, only: %i[show edit update destroy]

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
  end


  def new
    @member = Member.new(birthday: Date.new(1990, 1,1))
  end


  def edit
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to [:admin, @member], notice: "会員を登録しました。"
    else
      render "new"
    end
  end

  def update
    @member.assign_attributes(member_params)
    if @member.save
      redirect_to [:admin, @member], notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @member.destroy
    redirect_to :admin_members, notice: "会員を削除しました。"
  end

  # ストロングパラメーター
  private def member_params
    attrs = [
      :new_profile_picture,
      :remove_profile_picture,
      :number,
      :introduction,
      :name,
      :sex,
      :birthday,
      :address,
      :email,
      :git,
      :introduction_name,
      :portfolio,
      :school,
      :administrator
    ]

    attrs << :password if action_name == "create"

    params.require(:member).permit(attrs)
  end

  # リファクタリング
  def set_target_member
    @member = Member.find(params[:id])
  end
end