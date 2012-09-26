# -*- encoding : utf-8 -*-
class MemberMailer < ActionMailer::Base
  default from: "boladaodeamor123@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.tell_user.subject
  #
  def tell_user(member)
    @member = member

    mail(:to => member.profile.email, :subject => "Site 4soft, sistema de membros")
  end
end
