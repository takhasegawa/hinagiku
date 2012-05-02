# -*- encoding: UTF-8 -*-

tak = User.find_by_login_name("tak")

["仕事","生活","趣味"].each do |name|
  Category.create({:name => name, :owner => tak},
    :without_protection => true)
end

tasks = Task.order('id').limit(5).all
categories = Category.order('id').all

categories[1].tasks << tasks[0]
categories[0].tasks << tasks[1]
categories[1].tasks << tasks[2]
categories[0].tasks << tasks[3]
categories[1].tasks << tasks[4]