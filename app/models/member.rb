class Member < ActiveRecord::Base
  attr_accessible :bio, :facebook, :github, :linkedin,
    :name, :telefone, :twitter

  has_one :profile, :as => :profileable, :class_name => "User"

  accepts_nested_attributes_for :profile

end
