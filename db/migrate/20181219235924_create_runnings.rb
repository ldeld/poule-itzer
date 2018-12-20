class CreateRunnings < ActiveRecord::Migration[5.1]
  def change
    create_table :runnings do |t|
      t.boolean :status
      t.timestamps
    end
  end
end
