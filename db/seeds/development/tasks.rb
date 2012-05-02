# -*- encoding: UTF-8 -*-

tak = User.find_by_login_name("tak")
alice = User.find_by_login_name("alice")

names = [
  "切手を買う",
  "報告書を書く",
  "家賃を払う",
  "猫のえさを買う",
  "燃えないゴミをだす"
]

description = "これは説明です" * 20

5.times do |n|
  Task.create({:name => names[n],
                     :description => description,
                     :due_date => (n-2).days.from_now,
                     :done => n.zero?,
                     :owner => tak},
    :without_protection => true)
end

200.times do |n|
  Task.create({:name => "Task #{n}",
                     :description => description,
                     :due_date =>(n + 3).days.from_now,
                     :done => false,
                     :owner => alice},
    :without_protection => true)
end
