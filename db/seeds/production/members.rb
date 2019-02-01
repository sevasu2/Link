names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤", "鈴木", "高橋", "田中"]
gnames = ["太郎", "次郎", "花子"]
0.upto(9) do |idx|
  Member.create(
    number: idx + 10,
    name: names[idx],
    email: "#{names[idx]}@example.com",
    birthday: "1981-12-01",
    sex: [1, 1, 2][idx % 3],
    school: "スクール",
    git: "https://sevasu.com",
    portfolio: "https://sevasu.com",
    introduction_name: "Link",
    administrator: (idx == 0),
    password: "asagao!",
    password_confirmation: "asagao!"
  )
end
