class EntryImagesController < ApplicationController
  before_action :login_required #ログインしているか

  before_action do
    @entry = current_member.entries.find(params[:entry_id]) #ログインしているポートフォリオデータ
  end

   before_action :set_target_entry_image, only: %i[edit update destroy move_higher move_lower]

  #画像の一覧
  def index
    @images = @entry.images.order(:position)
  end

  #詳細ページ
  def show
    redirect_to action: "edit" #編集ページに遷移
  end

  #新規フォーム
  def new
    @image = @entry.images.build
  end

  # 編集ページ
  def edit
  end

  # 新規作成
  def create
    @image = @entry.images.build(image_params)
    if @image.save
      redirect_to [@entry, :images], notice: "画像を作成しました。"
    else
      render "new"
    end
  end

  # 更新
  def update
    @image.assign_attributes(image_params)
    if @image.save
      redirect_to [@entry, :images], notice: "画像を更新しました。"
    else
      render "edit"
    end
  end

  # 削除
  def destroy
    @image.destroy
    redirect_to [@entry, :images], notice: "画像を削除しました。"
  end

  # 表示位置を上げる
  def move_higher
    @image.move_higher
    redirect_back fallback_location: [@entry, :images]
  end

  # 表示位置を下げる
  def move_lower
    @image.move_lower
    redirect_back fallback_location: [@entry, :images]
  end

  # ストロング・パラメータ
  private def image_params
    params.require(:image).permit(
      :new_data,
      :alt_text
    )
  end

  def set_target_entry_image
    @image = @entry.images.find(params[:id])
  end
end
