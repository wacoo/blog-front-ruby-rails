require_relative 'comment'

class Post < ApplicationRecord
  after_initialize :update_posts_counter
  has_many :comments
  belongs_to :author, class_name: 'User'

  def update_posts_counter
    author.update(posts_counter: author.posts_counter.to_i + 1)
  end

  def self.five_recent_comments
    comments = Comment.joins(post: :author).order('comments.created_at DESC').limit(5)
    comments.map do |cmt|
      "User: #{cmt.post.author.name}, Comment: #{cmt.text}, Date: #{cmt.created_at}"
    end
  end
end
