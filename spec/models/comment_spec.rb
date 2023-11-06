require 'rails_helper'

RSpec.describe Comment, type: :model do
  it('comments_counter should increment') do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                       likes_counter: 0)
    before_comment = post.comments_counter
    Comment.create(post: post, user: user, text: 'Hi Tom!')
    after_comment = post.comments_counter
    expect(after_comment).to eql(before_comment + 1)
  end
end
