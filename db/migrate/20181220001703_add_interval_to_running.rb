class AddIntervalToRunning < ActiveRecord::Migration[5.1]
  def change
    add_column :runnings, :interval, :integer
  end
end
