class Member < ApplicationRecord
	has_secure_password

 #アソシエーション
  has_many :entries, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry
  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  #数字だけ、０以上、空欄禁止、重複禁止
  validates :number, presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      allow_blank: true
    },
    uniqueness: true
    #空欄禁止、文字数2~20文字、会員間の重複禁止
	validates :name, presence: true,
    length: { minimum: 2, maximum: 20 },
    uniqueness: { case_sensitive: false }
  validates :school, presence: true, length: { maximum: 30 }  #空欄禁止、最大30文字
  validates :portfolio, presence: true  #空欄禁止
  validates :introduction_name, presence: true  #空欄禁止
	validates :email, email: { allow_blank: true }  #メールアドレス構文チェック、ただし空欄可

	attr_accessor :current_password
  	validates :password, presence: { if: :current_password }

    #画像の種類のバリデーション
    validate if: :new_profile_picture do
    if new_profile_picture.respond_to?(:content_type)
      unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_profile_picture, :invalid_image_type)
      end
    else
      errors.add(:new_profile_picture, :invalid)
    end
  end

    before_save do
    if new_profile_picture
      self.profile_picture = new_profile_picture
    elsif remove_profile_picture
      self.profile_picture.purge
    end
  end

  # いいね機能
  #自分の記事には投票できない、1つの記事に1回しか投票できない
  def votable_for?(entry)
    entry && entry.author != self && !votes.exists?(entry_id: entry.id)
  end

  # 検索機能（会員名とスクール名で検索）
  class << self
      def search(query)
        rel = order("number")
       if query.present?
       	rel = rel.where(['name LIKE ? OR school LIKE ?', "%#{query}%", "%#{query}%"])
       end
       	rel
      end
   end
end

