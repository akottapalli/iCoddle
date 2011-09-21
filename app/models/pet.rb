class Pet < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo,
    :styles => { :medium => "300x300>", :thumb => "100x100>" }
    #:storage => :s3,
    #:s3_credentials => "#{Rails.root}/config/s3.yml",
    #:path => "/:style/:id/:filename"
end
