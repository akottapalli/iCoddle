class AddPhotoToPet < ActiveRecord::Migration
  def change
    add_column :pets, :photo_file_name, :string
    add_column :pets, :photo_content_type, :string
    add_column :pets, :photo_file_size, :integer
    add_column :pets, :photo_updated_at, :datetime
  end
end
