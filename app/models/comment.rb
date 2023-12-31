class Comment < ApplicationRecord
  after_create :update_comments_counter
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  private

  def update_comments_counter
    post.update(comments_counter: post.comments_counter.to_i + 1)
  end
end
