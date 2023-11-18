require 'swagger_helper'

describe 'Posts API' do
  path '/users/{user_id}/posts' do
    get 'Retrieves all posts for a user' do
      tags 'Posts'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'OK' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string }
                 },
                 required: %w[id title text]
               }

        run_test!
      end
    end
  end

  path '/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves all comments for a post' do
      tags 'Comments'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer
      response '200', 'OK' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   text: { type: :string }
                 },
                 required: %w[id text]
               }

        run_test!
      end
    end
  end

  path '/users/{user_id}/posts/{post_id}/comments' do
    post 'Creates a new comment' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'Created' do
        schema type: :object,
               properties: {
                 message: { type: :string }
               },
               required: ['message']

        run_test!
      end

      response '400', 'Bad Request' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: ['error']

        run_test!
      end
    end
  end
end
