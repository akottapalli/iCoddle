class Lead < ActiveRecord::Base
  validates_presence_of :email
  validates_format_of :email, :with => %r{.+@.+\..+}, :allow_blank => true
end
