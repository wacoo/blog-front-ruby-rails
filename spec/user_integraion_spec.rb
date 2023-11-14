require 'rails_helper'
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :chrome, options: {
      binary: '/usr/bin/google-chrome' # Replace with the actual Chrome binary location on your Chromebook
    }
  end
end
RSpec.describe 'User', type: :system do
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
    Post.create(author: user1, title: 'Name of the water', text: 'The book of water.', comments_counter: 0,
                likes_counter: 0)
  end
  context 'index' do
    scenario 'should display the correct images' do
      visit users_path
      expect(page).to have_css('img[src="https://media.giphy.com/media/tZaFa1m8UfzXy/giphy.gif"]')
      expect(page).to have_css('img[src="https://media.giphy.com/media/K4x1ZL36xWCf6/giphy.gif"]')
    end
    scenario 'should display the correct name and post count' do
      visit users_path
      expect(page).to have_content('John')
      expect(page).to have_content('Number of posts: 4')
    end
    scenario 'See user profile page when user name clicked' do
      visit user_path(user1)
      expect(page).to have_link('See all posts')
      click_link 'John'
      expect(page).to have_current_path(user_path(user1))
      visit user_path(@user2)
      click_link 'Lily'
      expect(page).to have_current_path(user_path(@user2))
    end
  end
  context 'show' do
    scenario 'profile should display the correct images' do
      visit users_path(user1)
      expect(page).to have_css('img[src="https://media.giphy.com/media/tZaFa1m8UfzXy/giphy.gif"]')
    end
    scenario 'should display the correct name' do
      visit users_path(user1)
      expect(page).to have_content('John')
    end
    scenario 'should display the correct post count' do
      visit users_path(user1)
      expect(page).to have_content('Number of posts: 4')
    end
    scenario 'should display the correct bio' do
      visit user_path(user1)
      expect(page).to have_content('This is John\'s bio')
    end
  end
  context 'show...' do
    scenario 'should display correct post titles and text' do
      visit user_path(user1)
      expect(page).to have_content('Name of the water')
      expect(page).to have_content('The book of water')
      expect(page).to have_content('Name of the earth')
      expect(page).to have_content('The book of earth')
      expect(page).to have_content('Name of the fire')
      expect(page).to have_content('The book of fire')
    end
    scenario 'should display the correct button' do
      visit user_path(user1)
      expect(page).to have_link('See all posts')
    end
    scenario 'on link click it should redirect to the right post' do
      visit user_path(user1)
      click_link 'Post: Name of the fire'
      expect(page).to have_current_path(user_post_path(user1, @post2))
    end
    scenario 'on link click it should redirect to users posts' do
      visit user_path(user1)
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(user1))
    end
  end
end
