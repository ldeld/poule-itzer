class AddLastTweetedAtToCocorocos < ActiveRecord::Migration[5.1]
  def change
    add_column :cocorocos, :last_tweeted_at, :datetime
  end
end
