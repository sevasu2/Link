class Entry < ApplicationRecord

  #アソシエーションの設定
  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  has_many :images, class_name: "EntryImage"
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :member
  has_many :comments

  STATUS_VALUES = %w(draft member_only public)  #状態の文字列はdraft,member_only,publicのいずれか


  validates :title, presence: true, length: { maximum: 200 } #空欄禁止、200文字まで
  validates :body, :posted_at, presence: true  #空欄禁止
  validates :status, inclusion: { in: STATUS_VALUES }  #状態に入るのは9行目の3の値のみ

  scope :common, -> { where(status: "public") }  #publicの値の記事を選ぶ
  scope :published, -> { where("status <> ?", "draft") }  #draft状態ではない記事
  scope :full, ->(member) {
    where("member_id = ? OR status <> ?", member.id, "draft") } #ある会員が書いた下書きではない状態の記事と自分の下書き記事
  scope :readable_for, ->(member) { member ? full(member) : common }  #commonスコープとfullスコープを使って、ログイン前のユーザーには公開記事だけ、ログイン後は公開記事、会員限定、自分の下書き記事を一覧で表示

  class << self
    #tメソッドを使って、statusカラムを日本語化する
    def status_text(status)
      I18n.t("activerecord.attributes.entry.status_#{status}")
    end

    #定数STATUS_VALUESを使って、[["下書き", "draft"],["会員限定", "member_only"]]の様な配列を作る
    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end
  end
end
