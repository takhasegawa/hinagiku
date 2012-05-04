users = %w(tak alice bob carol)

users.each do |name|
  user = User.new
  user.login_name = name
  user.display_name = name.capitalize
  user.password = "hoge" 
  user.setting_password = true
  user.save!
  email = Email.new(:address => user.login_name + "@example.com")
  email.verified_at = Time.current if user.login_name != "alice"
  user.emails << email
end