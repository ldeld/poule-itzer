class Cocoroco < ApplicationRecord
  validates :content, presence: true, length: { maximum: 240 }

  def twitter_formated_string
    self.content += " - #{self.author}" if self.author.present?
    self.content
  end
end
