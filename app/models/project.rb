class Project < ActiveRecord::Base
  attr_accessible :name, :project

  has_one :cover
  has_many :images, :as => :imageable, :class_name => "Image", :dependent => :destroy

  accepts_nested_attributes_for :images, :allow_destroy => true
end
