# -*- encoding : utf-8 -*-
class Admin < ActiveRecord::Base
  has_one :profile, :as => :profileable, :class_name => "User"
end
