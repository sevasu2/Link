class Member < ApplicationRecord
	has_secure_password

  has_many :entries, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry
  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  validates :number, presence: true,
    numericality: {
      only_integer: true,
      greater_than: 0,
      allow_blank: true
    },
    uniqueness: true
	validates :name, presence: true,
    length: { minimum: 2, maximum: 20 },
    uniqueness: { case_sensitive: false }
  validates :school, presence: true, length: { maximum: 30 }
  validates :portfolio, presence: true
  validates :introduction_name, presence: true
	validates :email, email: { allow_blank: true }

	attr_accessor :current_password
  	validates :password, presence: { if: :current_password }

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

