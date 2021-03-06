class Image < ActiveRecord::Base

	has_attached_file :file,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    :styles => { :thumb => "250x100" },
    :dropbox_options => {
      :path => proc { |style| "#{imageable.name}/#{style}/#{id}_#{file.original_filename}" }, :unique_filename => true
  	}

  attr_accessible :file, :file_content_type, :file_file_name, :file_file_size

  belongs_to :imageable, :polymorphic => true
end
