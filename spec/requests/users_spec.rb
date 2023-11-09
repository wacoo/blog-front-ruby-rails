require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    let!(:user) { User.create(name: 'Lily', photo: 'photos.com/lily', bio: 'this is my bio', posts_counter: 0) }

    it 'works! (now write some real specs)' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      get users_path
      expect(response.body).to render_template('index')
    end

    it 'correct place holder text' do
      get users_path
      expect(response.body).to include('Here is a list users')
    end
  end

  describe 'GET #show' do
    let!(:userx) { User.create(name: 'Rita', photo: 'photos.com/rita', bio: 'this is my bio', posts_counter: 0) }

    it 'returns a correct response' do
      get user_path(userx.id)
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      get user_path(userx.id)
      expect(response.body).to render_template('show')
    end

    it 'correct place holder text' do
      get user_path(userx.id)
      expect(response.body).to include('Here is a user')
    end
  end
end
