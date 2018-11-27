class Cocoroco < ApplicationRecord
  validates :author, presence: true
  validates :content, presence: true, length: { maximum: 240 }
end
