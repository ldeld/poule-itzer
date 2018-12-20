class Running < ApplicationRecord
  def self.status
    self.first.status
  end

  def self.status=(val)
    self.first.update_columns(status: val)
  end

  def self.interval
    self.first.interval
  end

  def self.interval=(val)
    self.first.update_columns(interval: val)
  end
end
