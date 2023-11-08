require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    let!(:user) { User.create(name: 'John', photo: 'photos.com/john', bio: 'this is my bio', posts_counter: 0) }
    let!(:post1) do
      Post.create(author: user, title: 'C++', text: 'C++ is great!', comments_counter: 0, likes_counter: 0)
    end

    it 'works! (now write some real specs)' do
      get user_posts_path(user)
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      get user_posts_path(user)
      expect(response.body).to render_template('index')
    end

    it 'correct place holder text' do
      get user_posts_path(user)
      expect(response.body).to include('Here is a list of posts')
    end
  end

  describe 'GET #show' do
    let!(:userx) { User.create(name: 'Sarah', photo: 'photos.com/sarah', bio: 'this is my bio', posts_counter: 0) }
    let!(:post3) do
      Post.create(author: userx, title: 'Art', text: 'Art is great!', comments_counter: 0, likes_counter: 0)
    end

    it 'returns a correct response' do
      get user_post_path(userx, post3)
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      get user_post_path(userx, post3)
      expect(response.body).to render_template('show')
    end

    it 'correct place holder text' do
      get user_post_path(userx, post3)
      expect(response.body).to include('Here is a post')
    end
  end
end
