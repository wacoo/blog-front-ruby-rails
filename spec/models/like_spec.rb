require 'rails_helper'

RSpec.describe Like, type: :model do
  it('comments_counter should increment') do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                       likes_counter: 0)
    before_like = post.likes_counter
    Like.create(post: post, user: user)
    after_like = post.likes_counter
    expect(after_like).to eql(before_like + 1)
  end
end
