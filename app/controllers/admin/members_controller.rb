class Admin::MembersController < Admin::Base

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


  def new
    @member = Member.new(birthday: Date.new(1990, 1,1))
  end


  def edit
    @member = Member.find(params[:id])
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
    @member = Member.find(params[:id])
    @member.assign_attributes(member_params)
    if @member.save
      redirect_to [:admin, @member], notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :admin_members, notice: "会員を削除しました。"
  end

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
end