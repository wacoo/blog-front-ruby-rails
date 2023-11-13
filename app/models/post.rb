require_relative 'comment'

class Post < ApplicationRecord
  after_create :update_posts_counter
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def liked_by?(user)
    likes.exists?(user: user)
  end

  private

  def update_posts_counter
    author.update(posts_counter: author.posts_counter.to_i + 1)
  end
end
