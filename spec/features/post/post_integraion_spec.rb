require 'rails_helper'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :chrome, options: {
      binary: '/usr/bin/google-chrome' # Replace with the actual Chrome binary location on your Chromebook
    }
  end
end

RSpec.describe 'Post', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user1) do
    User.create(name: 'John', photo: 'https://media.giphy.com/media/tZaFa1m8UfzXy/giphy.gif',
                bio: 'This is John\'s bio', posts_counter: 0)
  end

  before do
    @user2 = User.create(name: 'Lily', photo: 'https://media.giphy.com/media/K4x1ZL36xWCf6/giphy.gif',
                         bio: 'This is Lily\'s bio', posts_counter: 0)
    Post.create(author: user1, title: 'Name of the wind', text: 'The book of wind.', comments_counter: 0,
                likes_counter: 0)
    @post2 = Post.create(author: user1, title: 'Name of the fire', text: 'The book of fire.', comments_counter: 0,
                         likes_counter: 0)
    Post.create(author: user1, title: 'Name of the earth', text: 'The book of earth.', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: user1, title: 'Name of the water',
                text: 'The book of water and book of water book of water book of water book of water book of water' \
                      'book of water book of water book of water book of water book of water book of water book of' \
                      'water book of water book of water book of water', comments_counter: 0, likes_counter: 0)

    @cmt1 = Comment.create(user: @user2, post: @post2, text: 'Hey nice post!')
    @cmt2 = Comment.create(user: @user2, post: @post2, text: 'Hey great post!')
    @cmt3 = Comment.create(user: user1, post: @post2, text: 'Hey amazing post!')
    @cmt4 = Comment.create(user: @user2, post: @post2, text: 'When is the next?')

    @like1 = Like.create(user: @user2, post: @post2)
    @like1 = Like.create(user: user1, post: @post2)
  end
  context 'index' do
    scenario 'should display the correct images' do
      visit user_posts_path(user1)
      expect(page).to have_css('img[src="https://media.giphy.com/media/tZaFa1m8UfzXy/giphy.gif"]')
    end

    scenario 'should display the correct name and post count' do
      visit user_posts_path(user1)
      expect(page).to have_content('John')
      expect(page).to have_content('Number of posts: 4')
    end

    scenario 'should show post titles' do
      visit user_posts_path(user1)
      expect(page).to have_content('Post: Name of the wind')
      expect(page).to have_content('Post: Name of the earth')
      expect(page).to have_content('Post: Name of the water')
    end

    scenario 'should have part of post text' do
      visit user_posts_path(user1)
      expect(page).to have_content('The book of water and book of water')
      expect(page).to have_content('....')
    end

    scenario 'should show first few comments' do
      visit user_posts_path(user1)
      click_link '2'
      expect(page).to have_content('Comments')
      expect(page).to have_content('Hey nice post!')
      expect(page).to have_content('Hey great post!')
      expect(page).to have_content('Hey amazing post!')
      expect(page).to have_content('When is the next?')
    end
  end

  context 'index...' do
    scenario 'should show the number of comments for post' do
      visit user_posts_path(user1)
      click_link '2'
      expect(page).to have_content('Comments: 4')
    end

    scenario 'should show the number of like for a post' do
      visit user_posts_path(user1)
      click_link '2'
      expect(page).to have_content('Likes: 2')
    end

    scenario 'should redirect to the right post' do
      visit user_posts_path(user1)
      click_link '2'
      click_link 'Post: Name of the fire'
      expect(page).to have_current_path(user_post_path(user1, @post2))
    end

    scenario 'pagination links should work' do
      visit user_posts_path(user1)
      click_link '2'
      expect(page).to have_content('Post: Name of the fire')
      click_link '1'
      expect(page).to have_content('Post: Name of the wind')
      click_link '»'
      expect(page).to have_content('Post: Name of the fire')
      click_link '«'
      expect(page).to have_content('Post: Name of the wind')
    end
  end
  context 'show' do
    scenario 'should display the correct post title and author' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('Name of the fire by John')
    end

    scenario 'should show the number of comments for post' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('Comments: 4')
    end

    scenario 'should show the number of like for a post' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('Likes: 2')
    end

    scenario 'should show the post body' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('The book of fire.')
    end

    scenario 'should show the right comment and commentor for a comment' do
      visit user_post_path(user1, @post2)
      expect(page).to have_content('Lily: Hey nice post!')
      expect(page).to have_content('John: Hey amazing post!')
    end
  end
end
