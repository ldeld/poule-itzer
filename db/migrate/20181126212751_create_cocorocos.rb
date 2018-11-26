class CreateCocorocos < ActiveRecord::Migration[5.1]
  def change
    create_table :cocorocos do |t|
      t.text :content
      t.string :author

      t.timestamps
    end
  end
end
