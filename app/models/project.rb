class Project < ActiveRecord::Base
  attr_accessible :name, :description, :project

  has_one :cover, :as => :imageable, :class_name => "Cover", :dependent => :destroy
  has_many :images, :as => :imageable, :class_name => "Image", :dependent => :destroy

  accepts_nested_attributes_for :images, :allow_destroy => true

  def self.create(name, description, cover, images)
  	project = Project.new

    project.name = name
    project.description = description
    project.cover = Image.new(cover)

    images.values.each do |im|
      img = Image.new(im)
      project.images << img
    end

    project.save!

    return true
  rescue ActiveRecord::RecordInvalid => e
  	return false
  end
end
