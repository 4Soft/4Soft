class Project < ActiveRecord::Base
  attr_accessible :name

  has_many :images, :as => :imageable, :class_name => "Image"
end
