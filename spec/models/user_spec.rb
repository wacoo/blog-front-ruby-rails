require 'rails_helper'

RSpec.describe User, type: :model do
  # let!(:user1) { User.create(name: 'John', posts_counter: 3) }
  # let!(:user2) { User.create(name: 'Jane', posts_counter: 1) }
  # let!(:user3) { User.create(name: 'Alice', posts_counter: 2) }

  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
  before { subject.save }

  it('name should be present') do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it('posts_counter should be a number') do
    subject.posts_counter = nil
    expect(subject).not_to be_valid
  end

  it('posts_counter should be greater than or equal to 0') do
    subject.posts_counter = -1
    expect(subject).not_to be_valid
  end

  it('posts_counter should be equal to 0') do
    subject.posts_counter = 0
    expect(subject).to be_valid
  end

  it('posts_counter should be greater than 0') do
    subject.posts_counter = 3
    expect(subject).to be_valid
  end

  it 'returns the three most recent users' do
    user1 = User.create(name: 'John', photo: 'https://example.com/photo1.jpg', bio: 'Bio 1', posts_counter: 3)
    user2 = User.create(name: 'Jane', photo: 'https://example.com/photo2.jpg', bio: 'Bio 2', posts_counter: 1)
    user3 = User.create(name: 'Alice', photo: 'https://example.com/photo3.jpg', bio: 'Bio 3', posts_counter: 2)

    recent_users = User.recent_three.to_a
    expect(recent_users).to match_array([user1, user3, user2])
  end
end
