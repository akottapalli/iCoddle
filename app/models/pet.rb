class Pet < ActiveRecord::Base
  belongs_to :user
  has_attached_file :photo,
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :storage => :s3,
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :bucket => ENV['S3_BUCKET'], 
    :path => "/:style/:id/:filename"
end
