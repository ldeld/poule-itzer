class AddImageUrlToCocorocos < ActiveRecord::Migration[5.1]
  def change
    add_column :cocorocos, :profile_image_url, :string
    add_column :cocorocos, :attached_image_url, :string
  end
end
