# -*- encoding: UTF-8 -*-

class AccountMailer < ActionMailer::Base
  default :from => "tak.es.hasegawa@gmail.com", :charset => "iso-2022-jp"
  
  def email_verification(email)
    @email = email
    mail( :to => email.address, :subject => "[Hinagiku] メールアドレスの確認")
  end
end
