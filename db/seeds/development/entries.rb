body =
  "転職するための準備完了、これからは転職活動にが本格化する。\n\n" +
  "まだまだ、駆け出しにするら立てていないので、これからもプログラミングも勉強！ " +
  "とうぶんは、転職を決めさらなる飛躍に努めなければ！" +
  "今後はまず、企業で就職してから、使う知識、言語をメインに勉強していいこうと思う。\n\n" +
  "WebCampProでは充実した3ヶ月をありがとうございました！"

%w(Taro Jiro Hana).each do |name|
  member = Member.find_by(name: name)
  0.upto(9) do |idx|
    entry = Entry.create(
      author: member,
      title: "イベント#{idx}",
      body: body,
      posted_at: 10.days.ago.advance(days: idx),
      status: %w(draft member_only public)[idx % 3]
    )

    if idx == 7 || idx == 8
      %w(John Mike Sophy).each do |name2|
        voter = Member.find_by(name: name2)
        voter.voted_entries << entry
      end
    end
  end
end
