class User < ApplicationRecord
  def self.recent_three
    order(created_at: :desc).limit(3)
  end
end
