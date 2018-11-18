class Member < ApplicationRecord
	has_secure_password

  has_many :entries, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry
  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

	validates :name, presence: true, length: { maximum: 20 }
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

  def votable_for?(entry)
    entry && entry.author != self && !votes.exists?(entry_id: entry.id)
  end

 # class << self
 #    def search(search)
 #      # rel = order("number")
 #      if search
 #      	Member.where(['name LIKE ?', "%#{search}%"]).reverse.order
 #      else
 #      	Member.all.reverse_order
 #      end
 #    end
 #  end
 #
  # def self.search(search) #ここでのself.はUser.を意味する
  #   if search
  #     where(['name LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示。User.は省略
  #   else
  #     all #全て表示。User.は省略
  #   end
  # end
end

