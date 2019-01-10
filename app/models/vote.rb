class Vote < ApplicationRecord
  belongs_to :entry
  belongs_to :member
  #上記多対多の構成（ポートフォリオと会員に属する）

  #独自の制限
  validate do
    unless member && member.votable_for?(entry) #会員でない、かつmember_model46行目自分の記事には投票できない、1つの記事に1回しか投票できない
      errors.add(:base, :invalid) #モデルオブジェクト全体にエラーを加える
    end
  end
end
