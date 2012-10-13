# -*- encoding : utf-8 -*-
class Member < ActiveRecord::Base
  attr_accessible :bio, :facebook, :github, :linkedin,
    :name, :telefone, :twitter

  has_one :profile, :as => :profileable, :class_name => "User"

  accepts_nested_attributes_for :profile

  def self.generate_password
 		return ('a'..'z').to_a.shuffle[0,8].join
  end

  def self.create(email)
  	transaction do
	  	password = generate_password

	    user = User.new
	    user.email = email
	    user.password = password
	    user.password_confirmation = password
	    user.save!

	    member = Member.new
	    member.profile = user

	    member.save!

	    MemberMailer.tell_user(member).deliver
  	end

  	return true
  rescue ActiveRecord::RecordInvalid => e
  	return false
  end
end
