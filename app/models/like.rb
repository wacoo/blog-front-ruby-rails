class Like < ApplicationRecord
  after_initialize :update_likes_counter
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  private

  def update_likes_counter
    post.update(likes_counter: post.likes_counter.to_i + 1)
  end
end
