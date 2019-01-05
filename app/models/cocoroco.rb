class Cocoroco < ApplicationRecord

  def twitter_formated_string
    string = self.content
    string += " - #{author}" if author.present?
    string
  end

  def self.next_to_post
    Cocoroco.where(last_tweeted_at: nil).first || Cocoroco.order(:last_tweeted_at).first
  end
end
