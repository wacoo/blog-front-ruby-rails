class AddAuthorIdRefToPost < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :posts, :users, column: :author_id
  end
end
