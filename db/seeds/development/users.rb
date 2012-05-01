users = %w(tak alice bob carol)

users.each do |name|
  user = User.new
  user.login_name = name
  user.display_name = name.capitalize
  user.password = "hoge"
  user.save!
end