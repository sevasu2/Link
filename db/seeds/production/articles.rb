body =
  "インフラトップがDMM.comに買収されたとのこと\n\n" +
  "買収金額などは不明であるが、ベンチャーキャピタルなどが保有する発行済み株式の60％をDMMが21日付で取得。" +
  "IT人材の不足を背景にプログラミング教育市場は伸びているので、\n\n" +
  "DMMの参加でさらなる成長を目指すのこと。"

0.upto(9) do |idx|
  Article.create(
    title: "ニュース#{idx}",
    body: body,
    released_at: 8.days.ago.advance(days: idx),
    expired_at: 2.days.ago.advance(days: idx),
    member_only: (idx % 3 == 0)
  )
end

0.upto(29) do |idx|
  Article.create(
    title: "Article#{idx+10}",
    body: "blah, blah, blah...",
    released_at: 100.days.ago.advance(days: idx),
    expired_at: nil,
    member_only: false
  )
end
